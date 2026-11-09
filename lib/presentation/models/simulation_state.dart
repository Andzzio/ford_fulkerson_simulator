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
    this.showResidual = false,
  });

  final SimulationStatus status;
  final int currentStep;
  final List<SimulationEvent> events;
  final int maxFlow;
  final bool showResidual;

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

  Map<String, int> getFlowsWithVirtual(
    List<EdgeUi> realEdges,
    List<EdgeUi> virtualEdges,
  ) {
    final flows = Map<String, int>.from(currentFlows);
    for (final vEdge in virtualEdges) {
      if (vEdge.core.from == '__super_source__') {
        final srcId = vEdge.core.to;
        var outFlow = 0;
        for (final e in realEdges) {
          final f = flows[e.core.id] ?? e.core.flow;
          if (e.core.from == srcId) outFlow += f;
          if (e.core.to == srcId) outFlow -= f;
        }
        flows[vEdge.core.id] = outFlow < 0 ? 0 : outFlow;
      } else if (vEdge.core.to == '__super_sink__') {
        final snkId = vEdge.core.from;
        var inFlow = 0;
        for (final e in realEdges) {
          final f = flows[e.core.id] ?? e.core.flow;
          if (e.core.to == snkId) inFlow += f;
          if (e.core.from == snkId) inFlow -= f;
        }
        flows[vEdge.core.id] = inFlow < 0 ? 0 : inFlow;
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
        colors['__super_source__'] = Colors.cyanAccent;
        colors['__super_sink__'] = Colors.cyanAccent;
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
        colors['__super_source__'] = Colors.greenAccent;
        colors['__super_sink__'] = Colors.redAccent;
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
        if (pathNodeIds.isNotEmpty) {
          colors['__virtual_s_${pathNodeIds.first}__'] = Colors.cyanAccent;
          colors['__virtual_t_${pathNodeIds.last}__'] = Colors.cyanAccent;
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

  static String residualBackKey(String edgeId) => '$edgeId:rev';

  Map<String, Color> getResidualEdgeColors(List<EdgeUi> edges) {
    final colors = <String, Color>{};
    final event = currentEvent;
    if (event == null) return colors;
    switch (event) {
      case SimulationEvent_InspectNode():
        break;
      case SimulationEvent_TraverseEdge(:final edgeId, :final from):
        final edge = edges.where((e) => e.core.id == edgeId).firstOrNull;
        if (edge == null) break;
        final key = edge.core.from == from ? edgeId : residualBackKey(edgeId);
        colors[key] = Colors.orangeAccent;
      case SimulationEvent_PathFound(:final pathNodeIds):
        for (var i = 0; i < pathNodeIds.length - 1; i++) {
          final u = pathNodeIds[i];
          final v = pathNodeIds[i + 1];
          for (final edge in edges) {
            if (edge.core.from == u && edge.core.to == v) {
              colors[edge.core.id] = Colors.cyanAccent;
            } else if (edge.core.from == v && edge.core.to == u) {
              colors[residualBackKey(edge.core.id)] = Colors.cyanAccent;
            }
          }
        }
        if (pathNodeIds.isNotEmpty) {
          colors['__virtual_s_${pathNodeIds.first}__'] = Colors.cyanAccent;
          colors['__virtual_t_${pathNodeIds.last}__'] = Colors.cyanAccent;
        }
      case SimulationEvent_PushFlow(:final edgeId, :final delta):
        final color = delta >= 0 ? Colors.greenAccent : Colors.purpleAccent;
        colors[edgeId] = color;
        colors[residualBackKey(edgeId)] = color;
      case SimulationEvent_Finished():
        break;
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

  Map<String, NodeLabel> getNodeLabels(
    List<NodeUi> nodes,
    List<EdgeUi> edges,
  ) {
    final labels = <String, NodeLabel>{};
    if (!isSimulating || currentStep <= 0 || events.isEmpty) {
      return labels;
    }

    final nodeLabelMap = {for (final n in nodes) n.id: n.label};
    final edgeMap = {for (final e in edges) e.core.id: e.core};
    final sourceIds = [
      for (final n in nodes)
        if (n.core.nodeType == NodeType.source) n.id,
    ];

    final flows = <String, int>{};
    final deltas = <String, int>{};
    var resetOnNextInspect = true;

    for (var i = 0; i < currentStep && i < events.length; i++) {
      final event = events[i];
      switch (event) {
        case SimulationEvent_InspectNode():
          if (resetOnNextInspect) {
            labels.clear();
            deltas.clear();
            for (final sourceId in sourceIds) {
              labels[sourceId] = const NodeLabel(
                predecessor: '-',
                delta: '∞',
              );
            }
            resetOnNextInspect = false;
          }
        case SimulationEvent_TraverseEdge(
          :final edgeId,
          :final from,
          :final to,
        ):
          final edge = edgeMap[edgeId];
          if (edge == null) break;
          final fromLabel = nodeLabelMap[from] ?? from;
          final currentFlow = flows[edgeId] ?? edge.flow;
          final isForward = edge.from == from && edge.to == to;
          final residual = isForward
              ? (edge.capacity - currentFlow)
              : currentFlow;
          final prevDelta = deltas[from];
          final newDelta =
              (prevDelta != null && prevDelta < residual) ? prevDelta : residual;
          deltas[to] = newDelta;
          labels[to] = NodeLabel(
            predecessor: fromLabel,
            sign: isForward ? '+' : '-',
            delta: '$newDelta',
          );
        case SimulationEvent_PathFound():
          break;
        case SimulationEvent_PushFlow(:final edgeId, :final newFlow):
          flows[edgeId] = newFlow;
          resetOnNextInspect = true;
        case SimulationEvent_Finished():
          break;
      }
    }

    return labels;
  }

  SimulationState copyWith({
    SimulationStatus? status,
    int? currentStep,
    List<SimulationEvent>? events,
    int? maxFlow,
    bool? showResidual,
  }) {
    return SimulationState(
      status: status ?? this.status,
      currentStep: currentStep ?? this.currentStep,
      events: events ?? this.events,
      maxFlow: maxFlow ?? this.maxFlow,
      showResidual: showResidual ?? this.showResidual,
    );
  }
}

class NodeLabel {
  const NodeLabel({
    required this.predecessor,
    this.sign,
    required this.delta,
  });

  final String predecessor;
  final String? sign;
  final String delta;
}
