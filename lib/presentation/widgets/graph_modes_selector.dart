import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ford_fulkerson_simulator/presentation/notifiers/graph_mode_notifier.dart';
import 'package:ford_fulkerson_simulator/presentation/notifiers/graph_state_notifier.dart';
import 'package:ford_fulkerson_simulator/presentation/notifiers/simulation_notifier.dart';
import 'package:ford_fulkerson_simulator/presentation/widgets/graph_mode.dart';
import 'package:ford_fulkerson_simulator/presentation/widgets/toolbar_selector.dart';

class GraphModesSelector extends ConsumerWidget {
  const GraphModesSelector({super.key});

  Color _getRemainingBadgeColor(int remaining) {
    if (remaining == 0) return Colors.grey;
    if (remaining < 4) return Colors.redAccent;
    if (remaining < 8) return Colors.orangeAccent;
    return Colors.greenAccent;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = ref.watch(graphModeNotifier);
    final modeNotifier = ref.read(graphModeNotifier.notifier);
    final isSimulating = ref.watch(simulationNotifier).isSimulating;
    final graphNotifier = ref.read(graphStateNotifier.notifier);
    final graphState = ref.watch(graphStateNotifier);
    final remainingNodes = (16 - graphState.nodes.length).clamp(0, 16);

    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 10,
      children: [
        ToolbarSelector(
          isActive: mode == GraphMode.move,
          prefixIcon: FontAwesomeIcons.arrowsUpDownLeftRight,
          label: 'Mover',
          onTap: isSimulating
              ? null
              : () {
                  graphNotifier.unselectNode();
                  modeNotifier.changeMode(GraphMode.move);
                },
        ),
        Badge(
          backgroundColor: _getRemainingBadgeColor(remainingNodes),
          label: Text(
            '$remainingNodes',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          child: ToolbarSelector(
            isActive: mode == GraphMode.add,
            prefixIcon: FontAwesomeIcons.circlePlus,
            label: 'Agregar Nodos',
            onTap: isSimulating
                ? null
                : () {
                    graphNotifier.unselectNode();
                    modeNotifier.changeMode(GraphMode.add);
                  },
          ),
        ),
        ToolbarSelector(
          isActive: mode == GraphMode.join,
          prefixIcon: FontAwesomeIcons.link,
          label: 'Conectar Nodos',
          onTap: isSimulating
              ? null
              : () {
                  graphNotifier.unselectNode();
                  modeNotifier.changeMode(GraphMode.join);
                },
        ),
        ToolbarSelector(
          isActive: mode == GraphMode.delete,
          prefixIcon: FontAwesomeIcons.eraser,
          label: 'Borrar Elementos',
          onTap: isSimulating
              ? null
              : () {
                  graphNotifier.unselectNode();
                  modeNotifier.changeMode(GraphMode.delete);
                },
        ),
      ],
    );
  }
}
