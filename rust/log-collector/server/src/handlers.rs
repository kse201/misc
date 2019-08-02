use actix_web::{HttpResponse, Json, Query, State};
use failure::Error;
use log::debug;

use crate::Server;

pub fn handle_post_logs(server: State<Server>) -> Result<HttpResponse, Error> {
    let logs = Default::default();
    Ok(HttpResponse::Ok().json(api::csv::post::Response(logs)))
}

pub fn handle_get_logs(
    server: State<Server>,
    range: Query<api::log::get::Query>,
) -> Result<HttpResponse, Error> {
    debug!("{:?}", range);
    let logs = Default::default();

    Ok(HttpResponse::Ok().json(api::log::get::Response(logs)))
}

pub fn handle_post_csv(server: State<Server>) -> Result<HttpResponse, Error> {
    let logs = Default::default();
    Ok(HttpResponse::Ok().json(api::csv::post::Response(logs)))
}

pub fn handle_get_csv(
    server: State<Server>,
    log: Json<api::log::post::Request>,
) -> Result<HttpResponse, Error> {
    debug!("{:?}", log);
    Ok(HttpResponse::Accepted().finish())
}
