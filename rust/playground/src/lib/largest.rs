use std::fmt::Display;

pub fn largest<T>(list: &[T]) -> T
where
    T: PartialOrd + Copy,
{
    let mut large = list[0];

    for &item in list.iter() {
        if item > large {
            large = item
        }
    }
    large
}

pub fn longest_with_an_announcement<'a, T>(x: &'a str, y: &'a str, ann: T) -> &'a str
where
    T: Display,
{
    println!("Announcement! {}", ann);
    if x.len() > y.len() {
        x
    } else {
        y
    }
}
