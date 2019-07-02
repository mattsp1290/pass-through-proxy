use std::env;

fn main() {
    let mut counter = 0;
    while true {
        let port = env::var(format!("PORT_{}", counter)).unwrap_or("".to_string());
        if port.is_empty() && counter > 0 {
            println!("PORT_{} not set. Breaking.", counter);
            break;
        }
        counter += 1;
    }
}
