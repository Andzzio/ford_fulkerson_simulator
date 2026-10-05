import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
    final nodeMap = {for (final n in graphState.nodes) n.id: n.label};

    final currentEvents =
        simulationState.events.take(simulationState.currentStep);
    final pathEvents =
        currentEvents.whereType<SimulationEvent_PathFound>().toList();
    final finishedEvent =
        currentEvents.whereType<SimulationEvent_Finished>().firstOrNull;

    return SizedBox(
      width: 280,
      child: Card(
        child: ExpansionTile(
          initiallyExpanded: true,
          title: Text('Historial (${pathEvents.length})'),
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 260),
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
                          'Corte S: {${finishedEvent.minCutSourceNodes.map((id) => nodeMap[id] ?? id).join(', ')}}\n'
                          'Corte T: {${finishedEvent.minCutSinkNodes.map((id) => nodeMap[id] ?? id).join(', ')}}',
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
