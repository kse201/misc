use actix_web::http::Method;
use actix_web::App;

mod handlers;

#[derive(Clone)]
pub struct Server {}

impl Server {
    pub fn new() -> Self {
        Server {}
    }
}

pub fn app(server: Server) -> App<Server> {
    use handlers::*;

    let app: App<Server> = App::with_state(server)
        .route("/logs", Method::POST, handle_post_logs)
        .route("/csv", Method::POST, handle_post_csv)
        .route("/csv", Method::GET, handle_get_csv)
        .route("/logs", Method::GET, handle_get_logs);
    app
}

fn main() {
    env_logger::init();

    let server = Server::new();
    actix_web::server::new(move || app(server.clone()))
        .bind("0.0.0.0:3000")
        .expect("Can not bind to port 3000")
        .run();
}
