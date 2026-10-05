import 'package:flutter/material.dart';
import 'package:ford_fulkerson_simulator/presentation/widgets/graph_actions_selector.dart';
import 'package:ford_fulkerson_simulator/presentation/widgets/graph_capacity_slider.dart';
import 'package:ford_fulkerson_simulator/presentation/widgets/graph_menus_selector.dart';
import 'package:ford_fulkerson_simulator/presentation/widgets/graph_modes_selector.dart';

class GraphToolbar extends StatelessWidget {
  const GraphToolbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Wrap(
        spacing: 12,
        runSpacing: 10,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: const [
          GraphMenusSelector(),
          GraphModesSelector(),
          GraphActionsSelector(),
          GraphCapacitySlider(),
        ],
      ),
    );
  }
}
