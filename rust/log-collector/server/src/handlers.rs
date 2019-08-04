use crate::db;
use crate::model::NewLog;
use actix_web::{HttpResponse, Json, Query, State};
use chrono::{DateTime, Utc};
use failure::Error;
use log::debug;

use crate::Server;

pub fn handle_post_logs(
    server: State<Server>,
    log: Json<api::log::post::Request>,
) -> Result<HttpResponse, Error> {
    let log = NewLog {
        user_agent: log.user_agent.clone(),
        response_time: log.response_time,
        timestamp: log.timestamp.unwrap_or_else(|| Utc::now()).naive_utc(),
    };

    let con = server.pool.get()?;
    db::insert_log(&con, &log)?;
    debug!("received log: {:?}", log);

    Ok(HttpResponse::Accepted().finish())
}

pub fn handle_get_logs(
    server: State<Server>,
    range: Query<api::log::get::Query>,
) -> Result<HttpResponse, Error> {
    let conn = server.pool.get()?;
    let logs = db::logs(&conn, range.from, range.until)?;
    let logs = logs
        .into_iter()
        .map(|log| api::Log {
            user_agent: log.user_agent,
            response_time: log.response_time,
            timestamp: DateTime::from_utc(log.timestamp, Utc),
        })
        .collect();
    Ok(HttpResponse::Ok().json(api::log::get::Response(logs)))
}

use actix_web::FutureResponse;
use actix_web_multipart_file::FormData;
use actix_web_multipart_file::Multiparts;
use diesel::pg::PgConnection;
use futures::prelude::*;
use itertools::Itertools;
use std::io::BufReader;
use std::io::Read;

pub fn handle_post_csv(
    server: State<Server>,
    mutlparts: Multiparts,
) -> FutureResponse<HttpResponse> {
    let fut = mutlparts
        .from_err()
        .filter(|field| field.content_type == "text/csv")
        .filter_map(|field| match field.form_data {
            FormData::File { file, .. } => Some(file),
            FormData::Data { .. } => None,
        })
        .and_then(move |file| load_file(&*server.pool.get()?, file))
        .fold(0, |acc, x| Ok::<_, Error>(acc + x))
        .map(|sum| HttpResponse::Ok().json(api::csv::post::Response(sum)))
        .from_err();
    Box::new(fut)
}

pub fn handle_get_csv(
    server: State<Server>,
    range: Query<api::csv::get::Query>,
) -> Result<HttpResponse, Error> {
    let conn = server.pool.get()?;
    let logs = db::logs(&conn, range.from, range.until)?;
    let v = Vec::new();
    let mut w = csv::Writer::from_writer(v);

    for log in logs.into_iter().map(|log| ::api::Log {
        user_agent: log.user_agent,
        response_time: log.response_time,
        timestamp: DateTime::from_utc(log.timestamp, Utc),
    }) {
        w.serialize(log)?;
    }

    let csv = w.into_inner()?;

    Ok(HttpResponse::Ok()
        .header("Content-Type", "text/csv")
        .body(csv))
}

fn load_file(conn: &PgConnection, file: impl Read) -> Result<usize, Error> {
    let mut ret = 0;

    let in_csv = BufReader::new(file);
    let in_log = csv::Reader::from_reader(in_csv).into_deserialize::<api::Log>();
    for logs in &in_log.chunks(1000) {
        let logs = logs
            .filter_map(Result::ok)
            .map(|log| NewLog {
                user_agent: log.user_agent,
                response_time: log.response_time,
                timestamp: log.timestamp.naive_utc(),
            })
            .collect_vec();
        let inserted = db::insert_logs(conn, &logs)?;
        ret += inserted.len();
    }

    Ok(ret)
}
