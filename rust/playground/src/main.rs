mod lib;

use lib::largest;
use lib::NewsArticle;
use lib::Summary;
use lib::Tweet;

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
}

fn longest<'a>(x: &'a str, y: &'a str) -> &'a str {
    if x.len() > y.len() {
        x
    } else {
        y
    }
}
