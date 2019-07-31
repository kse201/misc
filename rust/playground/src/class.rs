pub struct Foo {
    x: i32,
    y: String,
}

impl Foo {
    pub fn new() -> Foo {
        Foo {
            x: 1,
            y: "y".to_string(),
        }
    }
}

impl std::fmt::Debug for Foo {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::result::Result<(), std::fmt::Error> {
        write!(f, "Hoge: {{x: {}, y: y is {} }}", self.x, self.y)
    }
}
