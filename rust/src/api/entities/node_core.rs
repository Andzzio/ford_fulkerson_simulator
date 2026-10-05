#[derive(Clone, PartialEq, Eq, Debug)]
pub enum NodeType {
    Source,
    Sink,
    Intermediate,
}

#[derive(Clone, PartialEq, Eq, Debug)]
pub struct NodeCore {
    pub id: String,
    pub label: String,
    pub node_type: NodeType,
}
impl NodeCore {}
