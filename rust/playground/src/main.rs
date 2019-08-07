mod lib;

use lib::largest;
use lib::NewsArticle;
use lib::Summary;
use lib::Tweet;

fn adverse_effect_func(a: *mut i32) -> Result<(), ()> {
    unsafe {
        *a += 1;
    }
    Ok(())
}

fn foo() -> String {
    let s: String = String::from("");

    s
}

fn main() {
    let tweet = Tweet {
        username: String::from("test_user"),
        content: String::from("hogehoge content"),
        reply: false,
        retweet: false,
    };

    let article = NewsArticle {
        headline: String::from("Penguins win the Stanley Cup Championship!"),
        location: String::from("Pittsburgh, PA, USA"),
        author: String::from("Iceburgh"),
        content: String::from(
            "The Pittsburgh Penguins once again are the best hockey team in the NHL.",
        ),
    };

    println!("{}", tweet.summarize());
    println!("{}", article.summarize());

    let number_list = vec![32, 50, 25, 1000, 65];
    assert_eq!(largest::largest(&number_list), 1000);

    let char_list = vec!['a', 'y', 'm', 'q'];
    assert_eq!(largest::largest(&char_list), 'y');

    lib::largest::longest_with_an_announcement("abcdef", "xyz", "Foo");

    let mut v = foo();

    println!("{}", v);
    v = String::from("foo");
    println!("{}", v);

    let mut a = 1;
    println!("{}", a);
    let _result = adverse_effect_func(&mut a);
    println!("{}", a);
}

fn longest<'a>(x: &'a str, y: &'a str) -> &'a str {
    if x.len() > y.len() {
        x
    } else {
        y
    }
}
