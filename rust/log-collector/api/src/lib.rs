use chrono::{DateTime, Utc};
use serde_derive::*;

#[derive(Debug, Clone, Deserialize, Serialize)]
pub struct Log {
    pub user_agent: String,
    pub response_time: i32,
    pub timestamp: DateTime<Utc>,
}

#[derive(Debug, Clone, Deserialize, Serialize)]
pub struct DateTimeRange {
    pub from: Option<DateTime<Utc>>,
    pub until: Option<DateTime<Utc>>,
}

/// /csv
pub mod csv {
    pub mod get {
        use crate::DateTimeRange;

        pub type Query = DateTimeRange;
    }

    pub mod post {
        use serde_derive::*;
        #[derive(Debug, Clone, Deserialize, Serialize)]
        pub struct Response(pub usize);
    }
}

/// /log
pub mod log {
    pub mod get {
        use crate::{DateTimeRange, Log};
        use serde_derive::*;

        pub type Query = DateTimeRange;

        #[derive(Debug, Clone, Deserialize, Serialize)]
        pub struct Response(pub Vec<Log>);
    }

    pub mod post {
        use chrono::{DateTime, Utc};
        use serde_derive::*;

        #[derive(Debug, Clone, Deserialize, Serialize)]
        pub struct Request {
            pub user_agent: String,
            pub response_time: i32,
            pub timestamp: Option<DateTime<Utc>>,
        }

        #[derive(Debug, Clone, Deserialize, Serialize)]
        pub struct Response(pub usize);
    }

}
