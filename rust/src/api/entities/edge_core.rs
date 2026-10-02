#[derive(Clone, PartialEq, Eq, Debug)]
pub struct EdgeCore {
    pub id: String,
    pub from: String,
    pub to: String,
    pub capacity: i32,
    pub flow: i32,
}
impl EdgeCore {}
