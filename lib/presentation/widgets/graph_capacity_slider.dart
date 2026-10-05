import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ford_fulkerson_simulator/config/theme/app_theme.dart';
import 'package:ford_fulkerson_simulator/presentation/notifiers/graph_state_notifier.dart';
import 'package:ford_fulkerson_simulator/presentation/notifiers/simulation_notifier.dart';

class GraphCapacitySlider extends ConsumerWidget {
  const GraphCapacitySlider({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final graphNotifier = ref.read(graphStateNotifier.notifier);
    final graphState = ref.watch(graphStateNotifier);
    final isSimulating = ref.watch(simulationNotifier).isSimulating;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('7', style: Theme.of(context).textTheme.bodyLarge),
        SizedBox(
          width: 140,
          child: Slider(
            activeColor: AppTheme.darkBorder,
            inactiveColor: Colors.transparent,
            value: graphState.nodesMaxCapacity.toDouble(),
            min: 7.0,
            max: 16.0,
            divisions: 9,
            label: '${graphState.nodesMaxCapacity}',
            onChanged: isSimulating
                ? null
                : (value) {
                    graphNotifier.changeNodesMaxCapacity(value.toInt());
                  },
          ),
        ),
        Text('16', style: Theme.of(context).textTheme.bodyLarge),
      ],
    );
  }
}
