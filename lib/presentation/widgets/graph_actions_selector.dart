import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ford_fulkerson_simulator/presentation/notifiers/graph_state_notifier.dart';
import 'package:ford_fulkerson_simulator/presentation/notifiers/simulation_notifier.dart';
import 'package:ford_fulkerson_simulator/presentation/widgets/outlined_button_elevated.dart';

class GraphActionsSelector extends ConsumerWidget {
  const GraphActionsSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final graphNotifier = ref.read(graphStateNotifier.notifier);
    final isSimulating = ref.watch(simulationNotifier).isSimulating;

    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 10,
      children: [
        OutlinedButtonElevated.icon(
          iconData: FontAwesomeIcons.trash,
          label: 'Limpiar',
          onPressed: isSimulating
              ? null
              : () {
                  graphNotifier.generateBlank();
                },
        ),
        OutlinedButtonElevated.icon(
          iconData: FontAwesomeIcons.dice,
          label: 'Generar grafo aleatorio',
          onPressed: isSimulating
              ? null
              : () {
                  graphNotifier.generateRandom();
                },
        ),
      ],
    );
  }
}
