import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ford_fulkerson_simulator/presentation/notifiers/graph_state_notifier.dart';
import 'package:ford_fulkerson_simulator/presentation/notifiers/simulation_notifier.dart';
import 'package:ford_fulkerson_simulator/presentation/notifiers/viewport_controller.dart';
import 'package:ford_fulkerson_simulator/presentation/widgets/app_popup_menu_button.dart';

class GraphMenusSelector extends ConsumerWidget {
  const GraphMenusSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final graphNotifier = ref.read(graphStateNotifier.notifier);
    final isSimulating = ref.watch(simulationNotifier).isSimulating;

    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 10,
      children: [
        AppPopupMenuButton<String>(
          prefixIcon: FontAwesomeIcons.hexagonNodes,
          label: 'Grafo',
          onSelected: isSimulating
              ? null
              : (value) {
                  if (value == 'new_graph') {
                    graphNotifier.generateBlank();
                    ref.read(viewportControllerProvider).centerGraph();
                  }
                },
          items: [
            _buildPopupMenuItemView(
              value: 'new_graph',
              icon: FontAwesomeIcons.file,
              label: 'Crear nuevo grafo',
            ),
          ],
        ),
        AppPopupMenuButton<String>(
          prefixIcon: FontAwesomeIcons.eye,
          label: 'Vista',
          onSelected: (value) {
            final viewport = ref.read(viewportControllerProvider);
            switch (value) {
              case 'center':
                viewport.centerGraph();
              case 'zoom_150':
                viewport.setZoom(1.5);
              case 'zoom_100':
                viewport.setZoom(1.0);
              case 'zoom_75':
                viewport.setZoom(0.75);
              case 'zoom_50':
                viewport.setZoom(0.5);
            }
          },
          items: [
            _buildPopupMenuItemView(
              value: 'center',
              icon: FontAwesomeIcons.crosshairs,
              label: 'Centrar grafo',
            ),
            _buildPopupMenuItemView(
              value: 'zoom_150',
              icon: FontAwesomeIcons.magnifyingGlassPlus,
              label: '150 %',
            ),
            _buildPopupMenuItemView(
              value: 'zoom_100',
              icon: FontAwesomeIcons.magnifyingGlass,
              label: '100 %',
            ),
            _buildPopupMenuItemView(
              value: 'zoom_75',
              icon: FontAwesomeIcons.magnifyingGlassMinus,
              label: '75 %',
            ),
            _buildPopupMenuItemView(
              value: 'zoom_50',
              icon: FontAwesomeIcons.magnifyingGlassMinus,
              label: '50 %',
            ),
          ],
        ),
      ],
    );
  }

  PopupMenuItem<String> _buildPopupMenuItemView({
    required String value,
    required FaIconData icon,
    required String label,
  }) {
    return PopupMenuItem<String>(
      value: value,
      child: Row(spacing: 10, children: [FaIcon(icon, size: 13), Text(label)]),
    );
  }
}
