extern crate iron;

use iron::prelude::*;
use iron::status;
use iron::Protocol;
use std::net::SocketAddr;

fn main() {
	fn hello_world(_: &mut Request) -> IronResult<Response> {
		Ok(Response::with((status::Ok, "Hello World!")))
	}

	let server_details = "127.0.0.1:8080";
	let server: SocketAddr = server_details.parse().unwrap();
	println!("Server {}", server);
	Iron::new(hello_world).listen_with(server, 8, Protocol::Http).unwrap();
}
