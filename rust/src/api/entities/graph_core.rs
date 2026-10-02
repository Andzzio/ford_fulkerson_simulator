use std::collections::HashSet;

use rand::random_range;

use crate::api::entities::{edge_core::EdgeCore, node_core::NodeCore};

#[derive(Clone, PartialEq, Eq, Debug)]
pub struct GraphCore {
    pub nodes: Vec<NodeCore>,
    pub edges: Vec<EdgeCore>,
}
impl GraphCore {
    #[flutter_rust_bridge::frb(sync)]
    pub fn generate_random(n: usize) -> Self {
        let mut nodes_random = Vec::with_capacity(n);
        let mut edges_random: Vec<EdgeCore> = Vec::new();
        for i in 0..n {
            nodes_random.push(NodeCore::new(
                i.to_string(),
                format!("{}", (b'A' + i as u8) as char),
            ));
        }
        for i in 0..(n - 1) {
            let max_available = n - 1 - i;
            let edge_out: usize = random_range(1..=max_available.min(3));
            let mut edge_visited: HashSet<usize> = HashSet::new();
            while edge_visited.len() < edge_out {
                let j: usize = random_range((i + 1)..(i + 4).min(n));
                if edge_visited.contains(&j) {
                    continue;
                }
                edge_visited.insert(j);
                edges_random.push(EdgeCore {
                    id: format!("{}->{}", i, j),
                    from: i.to_string(),
                    to: j.to_string(),
                    capacity: random_range(1..=16),
                    flow: 0,
                });
            }
        }
        Self {
            nodes: nodes_random,
            edges: edges_random,
        }
    }
    #[flutter_rust_bridge::frb(sync)]
    pub fn generate_blank() -> Self {
        Self {
            nodes: Vec::new(),
            edges: Vec::new(),
        }
    }
}
