extern crate serde;
extern crate serde_derive;
extern crate reqwest;

use serde_derive::{Serialize, Deserialize};
use reqwest::ClientBuilder;
use std::collections::HashMap;

#[derive(Serialize, Deserialize, Debug)]
struct Point {
    x: i32,
    y: i32,
}

#[derive(Serialize, Deserialize)]
struct Header {
    headers: HashMap<String, String>
}

fn service_show()-> Result<(), Box<std::error::Error>> {
    let proxy_user = "";
    let proxy_password = "";
    let proxy_host = "";
    let proxy_port = "";

    let id = "";
    let token = "";
    let url = "".to_string() + id;

    let raw_proxy = format!("http://{}:{}", proxy_host, proxy_port);
    let proxy = reqwest::Proxy::all(&raw_proxy)
        .unwrap()
        .basic_auth(proxy_user, proxy_password);

    let client = ClientBuilder::new()
        .danger_accept_invalid_certs(true)
        .proxy(proxy)
        .build()
        .unwrap();

    let resp: HashMap<String, String> = client
        .get(&url)
        .header("Authorization", "Bearer ".to_string() + token)
        .send()?.json()?;

    println!("{:#?}", resp);
    Ok(())
}

fn service_list()-> Result<(), Box<std::error::Error>> {
    let proxy_user = "";
    let proxy_password = "";
    let proxy_host = "";
    let proxy_port = "";

    let token = "";
    let url = "".to_string();

    let raw_proxy = format!("http://{}:{}", proxy_host, proxy_port);
    let proxy = reqwest::Proxy::all(&raw_proxy)
        .unwrap()
        .basic_auth(proxy_user, proxy_password);

    let client = ClientBuilder::new()
        .danger_accept_invalid_certs(true)
        .proxy(proxy)
        .build()
        .unwrap();

    let resp: HashMap<String, String> = client
        .get(&url)
        .header("Authorization", "Bearer ".to_string() + token)
        .send()?.json()?;

    println!("{:#?}", resp);
    Ok(())
}

fn api_request(url: String)-> Result<(), Box<std::error::Error>> {
    let proxy_user = "";
    let proxy_password = "";
    let proxy_host = "";
    let proxy_port = "";

    let token = "";

    let raw_proxy = format!("http://{}:{}", proxy_host, proxy_port);
    let proxy = reqwest::Proxy::all(&raw_proxy)
        .unwrap()
        .basic_auth(proxy_user, proxy_password);

    let client = ClientBuilder::new()
        .danger_accept_invalid_certs(true)
        .proxy(proxy)
        .build()
        .unwrap();

    // let resp: HashMap<String, String> = client
    // .get(&url)
    // .header("Authorization", "Bearer ".to_string() + token)
    // .send()?.json()?;

    let resp = client
        .get(&url)
        .header("Authorization", "Bearer ".to_string() + token)
        .send()?;
    println!("{:#?}", resp);
    Ok(())
}

fn main() -> Result<(), Box<std::error::Error>> {
    api_request("https://httpbin.org/headers".to_string())
}
