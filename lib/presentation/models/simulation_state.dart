import 'package:flutter/material.dart';
import 'package:ford_fulkerson_simulator/presentation/models/edge_ui.dart';
import 'package:ford_fulkerson_simulator/presentation/models/node_ui.dart';
import 'package:ford_fulkerson_simulator/presentation/widgets/simulation_status.dart';
import 'package:ford_fulkerson_simulator/src/rust/api/entities/node_core.dart';
import 'package:ford_fulkerson_simulator/src/rust/api/simulation_event.dart';

class SimulationState {
  SimulationState({
    this.status = SimulationStatus.stopped,
    this.currentStep = 0,
    this.events = const [],
    this.maxFlow = 0,
  });

  final SimulationStatus status;
  final int currentStep;
  final List<SimulationEvent> events;
  final int maxFlow;

  int get totalSteps => events.length;
  bool get isSimulating => status != SimulationStatus.stopped;

  SimulationEvent? get currentEvent =>
      (currentStep > 0 && currentStep <= events.length)
          ? events[currentStep - 1]
          : null;

  Map<String, int> get currentFlows {
    final flows = <String, int>{};
    for (var i = 0; i < currentStep && i < events.length; i++) {
      final event = events[i];
      if (event is SimulationEvent_PushFlow) {
        flows[event.edgeId] = event.newFlow;
      }
    }
    return flows;
  }

  Map<String, Color> get nodeBorderColors {
    final colors = <String, Color>{};
    final event = currentEvent;
    if (event == null) return colors;
    switch (event) {
      case SimulationEvent_InspectNode(:final nodeId, :final queueNodes):
        for (final qId in queueNodes) {
          colors[qId] = const Color(0x66FFAB40);
        }
        colors[nodeId] = Colors.orangeAccent;
      case SimulationEvent_TraverseEdge(
        :final from,
        :final to,
        :final queueNodes,
      ):
        for (final qId in queueNodes) {
          colors[qId] = const Color(0x66FFAB40);
        }
        colors[from] = Colors.orangeAccent;
        colors[to] = Colors.orangeAccent;
      case SimulationEvent_PathFound(:final pathNodeIds):
        for (final id in pathNodeIds) {
          colors[id] = Colors.cyanAccent;
        }
      case SimulationEvent_PushFlow(:final from, :final to, :final delta):
        final color = delta >= 0 ? Colors.greenAccent : Colors.purpleAccent;
        colors[from] = color;
        colors[to] = color;
      case SimulationEvent_Finished(:final minCutSourceNodes, :final minCutSinkNodes):
        for (final id in minCutSourceNodes) {
          colors[id] = Colors.greenAccent;
        }
        for (final id in minCutSinkNodes) {
          colors[id] = Colors.redAccent;
        }
    }
    return colors;
  }

  Map<String, Color> getEdgeColors(List<EdgeUi> edges) {
    final colors = <String, Color>{};
    final event = currentEvent;
    if (event == null) return colors;
    switch (event) {
      case SimulationEvent_InspectNode():
        break;
      case SimulationEvent_TraverseEdge(:final edgeId):
        colors[edgeId] = Colors.orangeAccent;
      case SimulationEvent_PathFound(:final pathNodeIds):
        for (var i = 0; i < pathNodeIds.length - 1; i++) {
          final u = pathNodeIds[i];
          final v = pathNodeIds[i + 1];
          for (final edge in edges) {
            if ((edge.core.from == u && edge.core.to == v) ||
                (edge.core.from == v && edge.core.to == u)) {
              colors[edge.core.id] = Colors.cyanAccent;
            }
          }
        }
      case SimulationEvent_PushFlow(:final edgeId, :final delta):
        colors[edgeId] = delta >= 0 ? Colors.greenAccent : Colors.purpleAccent;
      case SimulationEvent_Finished(:final minCutSourceNodes, :final minCutSinkNodes):
        final sourceSet = minCutSourceNodes.toSet();
        final sinkSet = minCutSinkNodes.toSet();
        for (final edge in edges) {
          if (sourceSet.contains(edge.core.from) &&
              sinkSet.contains(edge.core.to)) {
            colors[edge.core.id] = Colors.redAccent;
          }
        }
    }
    return colors;
  }

  int getSinkFlow(String sinkId, List<EdgeUi> edges) {
    var total = 0;
    for (final edge in edges) {
      if (edge.core.to == sinkId) {
        total += currentFlows[edge.core.id] ?? edge.core.flow;
      }
    }
    return total;
  }

  int getTotalSinkFlow(List<NodeUi> nodes, List<EdgeUi> edges) {
    var total = 0;
    for (final node in nodes) {
      if (node.core.nodeType == NodeType.sink) {
        total += getSinkFlow(node.id, edges);
      }
    }
    return total;
  }

  SimulationState copyWith({
    SimulationStatus? status,
    int? currentStep,
    List<SimulationEvent>? events,
    int? maxFlow,
  }) {
    return SimulationState(
      status: status ?? this.status,
      currentStep: currentStep ?? this.currentStep,
      events: events ?? this.events,
      maxFlow: maxFlow ?? this.maxFlow,
    );
  }
}
