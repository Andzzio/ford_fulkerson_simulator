use crate::api::{
    entities::graph_core::GraphCore, ford_fulkerson_solver::FordFulkersonSolver,
    simulation_event::SimulationResult,
};

#[flutter_rust_bridge::frb(sync)]
pub fn run_ford_fulkerson(graph: GraphCore) -> SimulationResult {
    let solver = FordFulkersonSolver::new(graph);
    solver.solve()
}
