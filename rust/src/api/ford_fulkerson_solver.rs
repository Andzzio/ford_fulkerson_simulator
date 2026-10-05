use std::collections::{HashMap, VecDeque};

use crate::api::{
    entities::{graph_core::GraphCore, node_core::NodeType},
    simulation_event::{SimulationEvent, SimulationResult},
};

pub struct FordFulkersonSolver {
    pub graph: GraphCore,
}

impl FordFulkersonSolver {
    pub fn new(graph: GraphCore) -> Self {
        Self { graph }
    }

    pub fn solve(self) -> SimulationResult {
        let n = self.graph.nodes.len();
        if n == 0 {
            return SimulationResult {
                max_flow: 0,
                events: Vec::new(),
            };
        }

        let mut id_to_index: HashMap<String, usize> = HashMap::new();
        let mut index_to_id: Vec<String> = Vec::with_capacity(n);
        let mut sources: Vec<usize> = Vec::new();
        let mut sinks: Vec<usize> = Vec::new();

        for (i, node) in self.graph.nodes.iter().enumerate() {
            id_to_index.insert(node.id.clone(), i);
            index_to_id.push(node.id.clone());
            match node.node_type {
                NodeType::Source => sources.push(i),
                NodeType::Sink => sinks.push(i),
                NodeType::Intermediate => {}
            }
        }

        if sources.is_empty() || sinks.is_empty() {
            return SimulationResult {
                max_flow: 0,
                events: Vec::new(),
            };
        }

        let mut capacity = vec![vec![0i32; n]; n];
        let mut flow = vec![vec![0i32; n]; n];
        let mut edge_id_map: Vec<Vec<Option<String>>> = vec![vec![None; n]; n];

        for edge in &self.graph.edges {
            if let (Some(&u), Some(&v)) = (id_to_index.get(&edge.from), id_to_index.get(&edge.to)) {
                capacity[u][v] += edge.capacity;
                edge_id_map[u][v] = Some(edge.id.clone());
            }
        }

        let mut events: Vec<SimulationEvent> = Vec::new();
        let mut max_flow = 0;

        loop {
            let mut visited = vec![false; n];
            let mut parent: Vec<Option<(usize, bool)>> = vec![None; n];
            let mut queue = VecDeque::new();

            for &s in &sources {
                visited[s] = true;
                queue.push_back(s);
            }

            let mut reached_sink = None;

            while let Some(u) = queue.pop_front() {
                let current_queue: Vec<String> =
                    queue.iter().map(|&idx| index_to_id[idx].clone()).collect();
                events.push(SimulationEvent::InspectNode {
                    node_id: index_to_id[u].clone(),
                    queue_nodes: current_queue,
                });

                if sinks.contains(&u) {
                    reached_sink = Some(u);
                    break;
                }

                for v in 0..n {
                    if !visited[v] {
                        if capacity[u][v] > flow[u][v] {
                            visited[v] = true;
                            parent[v] = Some((u, true));
                            queue.push_back(v);
                            let queue_snapshot: Vec<String> =
                                queue.iter().map(|&idx| index_to_id[idx].clone()).collect();
                            if let Some(ref eid) = edge_id_map[u][v] {
                                events.push(SimulationEvent::TraverseEdge {
                                    edge_id: eid.clone(),
                                    from: index_to_id[u].clone(),
                                    to: index_to_id[v].clone(),
                                    queue_nodes: queue_snapshot,
                                });
                            }
                        } else if flow[v][u] > 0 {
                            visited[v] = true;
                            parent[v] = Some((u, false));
                            queue.push_back(v);
                            let queue_snapshot: Vec<String> =
                                queue.iter().map(|&idx| index_to_id[idx].clone()).collect();
                            if let Some(ref eid) = edge_id_map[v][u] {
                                events.push(SimulationEvent::TraverseEdge {
                                    edge_id: eid.clone(),
                                    from: index_to_id[u].clone(),
                                    to: index_to_id[v].clone(),
                                    queue_nodes: queue_snapshot,
                                });
                            }
                        }
                    }
                }
            }

            let sink_node = match reached_sink {
                Some(s) => s,
                None => break,
            };

            let mut curr = sink_node;
            let mut path_segments = Vec::new();
            let mut bottleneck = i32::MAX;

            while let Some((p, is_forward)) = parent[curr] {
                if is_forward {
                    bottleneck = bottleneck.min(capacity[p][curr] - flow[p][curr]);
                    path_segments.push((p, curr, true));
                } else {
                    bottleneck = bottleneck.min(flow[curr][p]);
                    path_segments.push((p, curr, false));
                }
                curr = p;
            }
            path_segments.reverse();

            let mut path_node_ids = Vec::with_capacity(path_segments.len() + 1);
            if let Some(&(first_u, _, _)) = path_segments.first() {
                path_node_ids.push(index_to_id[first_u].clone());
            }
            for &(_, v, _) in &path_segments {
                path_node_ids.push(index_to_id[v].clone());
            }

            events.push(SimulationEvent::PathFound {
                path_node_ids,
                bottleneck,
            });

            for &(u, v, is_forward) in &path_segments {
                if is_forward {
                    flow[u][v] += bottleneck;
                    if let Some(ref eid) = edge_id_map[u][v] {
                        events.push(SimulationEvent::PushFlow {
                            edge_id: eid.clone(),
                            from: index_to_id[u].clone(),
                            to: index_to_id[v].clone(),
                            delta: bottleneck,
                            new_flow: flow[u][v],
                        });
                    }
                } else {
                    flow[v][u] -= bottleneck;
                    if let Some(ref eid) = edge_id_map[v][u] {
                        events.push(SimulationEvent::PushFlow {
                            edge_id: eid.clone(),
                            from: index_to_id[u].clone(),
                            to: index_to_id[v].clone(),
                            delta: -bottleneck,
                            new_flow: flow[v][u],
                        });
                    }
                }
            }

            max_flow += bottleneck;
        }

        let mut visited_cut = vec![false; n];
        let mut cut_queue = VecDeque::new();
        for &s in &sources {
            visited_cut[s] = true;
            cut_queue.push_back(s);
        }

        while let Some(u) = cut_queue.pop_front() {
            for v in 0..n {
                if !visited_cut[v] && (capacity[u][v] > flow[u][v] || flow[v][u] > 0) {
                    visited_cut[v] = true;
                    cut_queue.push_back(v);
                }
            }
        }

        let mut min_cut_source_nodes = Vec::new();
        let mut min_cut_sink_nodes = Vec::new();

        for i in 0..n {
            if visited_cut[i] {
                min_cut_source_nodes.push(index_to_id[i].clone());
            } else {
                min_cut_sink_nodes.push(index_to_id[i].clone());
            }
        }

        events.push(SimulationEvent::Finished {
            max_flow,
            min_cut_source_nodes,
            min_cut_sink_nodes,
        });

        SimulationResult { max_flow, events }
    }
}
