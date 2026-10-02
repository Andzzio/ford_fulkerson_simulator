import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ford_fulkerson_simulator/config/theme/app_theme.dart';
import 'package:ford_fulkerson_simulator/presentation/notifiers/graph_state_notifier.dart';
import 'package:ford_fulkerson_simulator/presentation/widgets/app_popup_menu_button.dart';
import 'package:ford_fulkerson_simulator/presentation/widgets/outlined_button_elevated.dart';
import 'package:ford_fulkerson_simulator/presentation/widgets/toolbar_selector.dart';

class GraphToolbar extends ConsumerStatefulWidget {
  const GraphToolbar({super.key});

  @override
  ConsumerState<GraphToolbar> createState() => _GraphToolbarState();
}

class _GraphToolbarState extends ConsumerState<GraphToolbar> {
  @override
  Widget build(BuildContext context) {
    final graphNotifier = ref.read(graphStateNotifier.notifier);
    final graphState = ref.watch(graphStateNotifier);
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        spacing: 10,
        children: [
          AppPopupMenuButton(
            prefixIcon: FontAwesomeIcons.hexagonNodes,
            label: 'Grafo',
            items: [
              _buildPopupMenuItemView(
                icon: FontAwesomeIcons.file,
                label: 'Crear nuevo grafo',
              ),
            ],
          ),
          AppPopupMenuButton(
            prefixIcon: FontAwesomeIcons.eye,
            label: 'Vista',
            items: [
              _buildPopupMenuItemView(
                icon: FontAwesomeIcons.magnifyingGlassPlus,
                label: '100 %',
              ),
              _buildPopupMenuItemView(
                icon: FontAwesomeIcons.magnifyingGlassPlus,
                label: '50 %',
              ),
              _buildPopupMenuItemView(
                icon: FontAwesomeIcons.magnifyingGlassPlus,
                label: '25 %',
              ),
            ],
          ),
          _buildVerticalSlider(),
          ToolbarSelector(
            isActive: true,
            prefixIcon: FontAwesomeIcons.arrowsUpDownLeftRight,
            label: 'Mover',
          ),
          ToolbarSelector(
            isActive: false,
            prefixIcon: FontAwesomeIcons.circlePlus,
            label: 'Agregar Nodos',
          ),
          ToolbarSelector(
            isActive: false,
            prefixIcon: FontAwesomeIcons.link,
            label: 'Conectar Nodos',
          ),
          ToolbarSelector(
            isActive: false,
            prefixIcon: FontAwesomeIcons.eraser,
            label: 'Borrar Elementos',
          ),
          _buildVerticalSlider(),
          OutlinedButtonElevated(
            iconData: FontAwesomeIcons.trash,
            label: 'Limpiar',
            onPressed: () {
              graphNotifier.generateBlank();
            },
          ),
          OutlinedButtonElevated(
            iconData: FontAwesomeIcons.dice,
            label: 'Generar grafo aleatorio',
            onPressed: () {
              graphNotifier.generateRandom();
            },
          ),
          _buildVerticalSlider(),
          Row(
            children: [
              Text('7', style: Theme.of(context).textTheme.bodyLarge),
              Slider(
                activeColor: AppTheme.darkBorder,
                inactiveColor: Colors.transparent,
                value: graphState.nodesMaxCapacity.toDouble(),
                min: 7.0,
                max: 16.0,
                divisions: 10,
                label: '${graphState.nodesMaxCapacity}',
                onChanged: (value) {
                  graphNotifier.changeNodesMaxCapacity(value.toInt());
                },
              ),
              Text('16', style: Theme.of(context).textTheme.bodyLarge),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildVerticalSlider() {
    return SizedBox(
      height: 40,
      child: VerticalDivider(color: Colors.blueAccent, thickness: 2),
    );
  }

  PopupMenuItem _buildPopupMenuItemView({
    required FaIconData icon,
    required String label,
  }) {
    return PopupMenuItem(
      child: Row(spacing: 10, children: [FaIcon(icon, size: 13), Text(label)]),
    );
  }
}
