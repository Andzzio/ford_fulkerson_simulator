#[derive(Clone, Debug, PartialEq, Eq)]
pub enum SimulationEvent {
    InspectNode {
        node_id: String,
        queue_nodes: Vec<String>,
    },
    TraverseEdge {
        edge_id: String,
        from: String,
        to: String,
        queue_nodes: Vec<String>,
    },
    PathFound {
        path_node_ids: Vec<String>,
        bottleneck: i32,
    },
    PushFlow {
        edge_id: String,
        from: String,
        to: String,
        delta: i32,
        new_flow: i32,
    },
    Finished {
        max_flow: i32,
        min_cut_source_nodes: Vec<String>,
        min_cut_sink_nodes: Vec<String>,
    },
}

#[derive(Clone, Debug, PartialEq, Eq)]
pub struct SimulationResult {
    pub max_flow: i32,
    pub events: Vec<SimulationEvent>,
}
