import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ford_fulkerson_simulator/presentation/models/edge_ui.dart';
import 'package:ford_fulkerson_simulator/presentation/notifiers/graph_state_notifier.dart';
import 'package:ford_fulkerson_simulator/presentation/notifiers/simulation_notifier.dart';
import 'package:ford_fulkerson_simulator/src/rust/api/simulation_event.dart';

class SimulationHistoryTile extends ConsumerWidget {
  const SimulationHistoryTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final simulationState = ref.watch(simulationNotifier);
    if (!simulationState.isSimulating) {
      return const SizedBox.shrink();
    }

    final graphState = ref.watch(graphStateNotifier);
    final nodeMap = {
      for (final n in graphState.nodes) n.id: n.label,
      for (final n in graphState.virtualNodes) n.id: n.label,
    };

    final currentEvents =
        simulationState.events.take(simulationState.currentStep);
    final pathEvents =
        currentEvents.whereType<SimulationEvent_PathFound>().toList();
    final finishedEvent =
        currentEvents.whereType<SimulationEvent_Finished>().firstOrNull;

    final cutEdges = finishedEvent != null
        ? graphState.edges.where((e) {
            final sourceSet = finishedEvent.minCutSourceNodes.toSet();
            final sinkSet = finishedEvent.minCutSinkNodes.toSet();
            return sourceSet.contains(e.core.from) &&
                sinkSet.contains(e.core.to);
          }).toList()
        : <EdgeUi>[];
    final cutCapacitySum = cutEdges.fold<int>(
      0,
      (sum, e) => sum + e.core.capacity,
    );
    final flows = simulationState.currentFlows;
    final cutEdgesStr = cutEdges.isEmpty
        ? 'Ninguna'
        : cutEdges.map((e) {
            final fromLabel = nodeMap[e.core.from] ?? e.core.from;
            final toLabel = nodeMap[e.core.to] ?? e.core.to;
            final f = flows[e.core.id] ?? e.core.flow;
            return '$fromLabel → $toLabel ($f/${e.core.capacity})';
          }).join(', ');
    final capacitySumStr = cutEdges.length > 1
        ? '${cutEdges.map((e) => e.core.capacity).join(' + ')} = $cutCapacitySum'
        : '$cutCapacitySum';

    return SizedBox(
      width: 330,
      child: Card(
        child: ExpansionTile(
          initiallyExpanded: true,
          title: Text('Historial (${pathEvents.length})'),
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 300),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (pathEvents.isEmpty)
                      const ListTile(
                        dense: true,
                        title: Text('Buscando caminos...'),
                      ),
                    for (var i = 0; i < pathEvents.length; i++) ...[
                      ListTile(
                        dense: true,
                        title: Text('Iteración ${i + 1}'),
                        subtitle: Text(
                          '${pathEvents[i].pathNodeIds.map((id) => nodeMap[id] ?? id).join(' → ')}  (+${pathEvents[i].bottleneck})',
                        ),
                      ),
                    ],
                    if (finishedEvent != null) ...[
                      const Divider(),
                      ListTile(
                        dense: true,
                        title: Text('Flujo Máximo: ${finishedEvent.maxFlow}'),
                        subtitle: Text(
                          'Corte S: {${[
                            ?graphState.superSourceNode?.id,
                            ...finishedEvent.minCutSourceNodes,
                          ].map((id) => nodeMap[id] ?? id).join(', ')}}\n'
                          'Corte T: {${[
                            ...finishedEvent.minCutSinkNodes,
                            ?graphState.superSinkNode?.id,
                          ].map((id) => nodeMap[id] ?? id).join(', ')}}\n'
                          'Aristas (S → T): $cutEdgesStr\n'
                          'Capacidad del corte = $capacitySumStr\n'
                          'Flujo máximo = ${finishedEvent.maxFlow}\n'
                          'Flujo Máximo (${finishedEvent.maxFlow}) = Capacidad del corte ($cutCapacitySum)',
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
