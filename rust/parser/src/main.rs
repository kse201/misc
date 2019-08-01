mod lib;

use lib::{show_trace, Ast, Interpreter, RpnCompiler};
use std::io;

pub fn prompt(s: &str) -> io::Result<()> {
    use std::io::{stdout, Write};
    let stdout = stdout();
    let mut stdout = stdout.lock();

    stdout.write(s.as_bytes())?;
    stdout.flush()
}

fn main() {
    use std::io::{stdin, BufRead, BufReader};
    let mut interp = Interpreter::new();
    let mut compiler = RpnCompiler::new();

    let stdin = stdin();
    let stdin = BufReader::new(stdin.lock());
    let mut lines = stdin.lines();
    loop {
        prompt("> ").unwrap();
        if let Some(Ok(line)) = lines.next() {
            let ast = match line.parse::<Ast>() {
                Ok(ast) => ast,
                Err(e) => {
                    e.show_diagnostic(&line);
                    show_trace(e);
                    continue;
                }
            };

            let n = match interp.eval(&ast) {
                Ok(n) => n,
                Err(e) => {
                    e.show_diagnostic(&line);
                    show_trace(e);
                    continue;
                }
            };
            println!("EVAL: {}", n);

            let rpn = compiler.compile(&ast);
            println!("RPN: {}", rpn);
        } else {
            break;
        }
    }
}
