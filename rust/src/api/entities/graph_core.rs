use std::collections::HashSet;

use rand::random_range;

use crate::api::entities::{
    edge_core::EdgeCore,
    node_core::{NodeCore, NodeType},
};

fn get_stage_sizes(n: usize) -> Vec<usize> {
    if n <= 3 {
        return vec![n];
    }
    let num_stages = if n <= 9 {
        4
    } else if n <= 13 {
        5
    } else {
        6
    };
    let intermediate_stages = num_stages - 2;
    let intermediate_nodes = n - 2;
    let base = intermediate_nodes / intermediate_stages;
    let mut rem = intermediate_nodes % intermediate_stages;

    let mut stages = vec![1];
    let mut mid = vec![base; intermediate_stages];
    let mut left = intermediate_stages / 2;
    let mut right = left;
    if intermediate_stages % 2 == 0 && left > 0 {
        left -= 1;
    }
    while rem > 0 {
        if rem > 0 && right < intermediate_stages {
            mid[right] += 1;
            rem -= 1;
        }
        if rem > 0 && left < right {
            mid[left] += 1;
            rem -= 1;
        }
        if left > 0 {
            left -= 1;
        }
        if right + 1 < intermediate_stages {
            right += 1;
        }
    }
    stages.extend(mid);
    stages.push(1);
    stages
}

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
            nodes_random.push(NodeCore {
                id: i.to_string(),
                label: format!("{}", (b'A' + i as u8) as char),
                node_type: NodeType::Intermediate,
            });
        }

        let stage_sizes = get_stage_sizes(n);
        let mut stages: Vec<Vec<usize>> = Vec::with_capacity(stage_sizes.len());
        let mut current_idx = 0;
        for size in &stage_sizes {
            let mut stage = Vec::with_capacity(*size);
            for _ in 0..*size {
                if current_idx < n {
                    stage.push(current_idx);
                    current_idx += 1;
                }
            }
            stages.push(stage);
        }

        let mut edge_set: HashSet<(usize, usize)> = HashSet::new();

        for s in 0..(stages.len().saturating_sub(1)) {
            let current_stage = &stages[s];
            let next_stage = &stages[s + 1];
            if next_stage.is_empty() {
                continue;
            }

            let m_curr = current_stage.len();
            let m_next = next_stage.len();

            for (i, &u) in current_stage.iter().enumerate() {
                let target_center = if m_curr <= 1 {
                    m_next / 2
                } else {
                    let pos = i as f64 / (m_curr - 1) as f64;
                    (pos * (m_next - 1) as f64).round() as usize
                };

                let mut candidates: Vec<usize> = Vec::new();
                if target_center > 0 {
                    candidates.push(next_stage[target_center - 1]);
                }
                candidates.push(next_stage[target_center]);
                if target_center + 1 < m_next {
                    candidates.push(next_stage[target_center + 1]);
                }

                let max_edges = if s == 0 {
                    m_next.min(3)
                } else if s + 2 == stages.len() {
                    1
                } else {
                    candidates.len().min(2)
                };

                let num_edges = if max_edges <= 1 {
                    max_edges
                } else {
                    random_range(1..=max_edges)
                };

                let mut picked: HashSet<usize> = HashSet::new();
                let mut attempts = 0;
                while picked.len() < num_edges && attempts < 20 {
                    attempts += 1;
                    let target_idx = random_range(0..candidates.len());
                    let v = candidates[target_idx];
                    if !picked.contains(&v) && !edge_set.contains(&(u, v)) {
                        picked.insert(v);
                        edge_set.insert((u, v));
                        edges_random.push(EdgeCore {
                            id: format!("{}->{}", u, v),
                            from: u.to_string(),
                            to: v.to_string(),
                            capacity: random_range(1..=16),
                            flow: 0,
                        });
                    }
                }
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
