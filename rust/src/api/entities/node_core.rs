#[derive(Clone, PartialEq, Eq, Debug)]
pub struct NodeCore {
    pub id: String,
    pub label: String,
}
impl NodeCore {
    pub fn new(id: String, label: String) -> Self {
        Self { id, label }
    }
}
