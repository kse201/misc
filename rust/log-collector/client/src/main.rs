#[macro_use]
extern crate clap;

use clap::{App, AppSettings, Arg, SubCommand};

arg_enum! {
#[derive(Debug)]
enum Format {
    Csv,
    Json
}

}

fn main() {
    let opts = clap::app_from_crate!()
        .setting(AppSettings::SubcommandRequiredElseHelp)
        .arg(
            Arg::with_name("SERVER")
                .short("s")
                .long("server")
                .value_name("URL")
                .help("server url")
                .takes_value(true),
        )
        .subcommand(SubCommand::with_name("post").about("post logs , taking input from stdin"))
        .subcommand(
            SubCommand::with_name("get").about("get logs").arg(
                Arg::with_name("FORMAT")
                    .short("f")
                    .long("format")
                    .takes_value(true)
                    .possible_values(&Format::variants())
                    .case_insensitive(true),
            ),
        );

    let matches = opts.get_matches();
    let server = matches.value_of("SERVER").unwrap_or("localhost:3000");

    match matches.subcommand() {
        ("get", sub_match) => println!("get: {:?}", sub_match),
        ("post", sub_match) => println!("post: {:?}", sub_match),
        _ => unreachable!(),
    }
}
