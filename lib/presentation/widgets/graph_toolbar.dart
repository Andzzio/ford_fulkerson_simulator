import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ford_fulkerson_simulator/presentation/widgets/app_popup_menu_button.dart';
import 'package:ford_fulkerson_simulator/presentation/widgets/outlined_button_elevated.dart';
import 'package:ford_fulkerson_simulator/presentation/widgets/toolbar_selector.dart';

class GraphToolbar extends StatefulWidget {
  const GraphToolbar({super.key});

  @override
  State<GraphToolbar> createState() => _GraphToolbarState();
}

class _GraphToolbarState extends State<GraphToolbar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: IntrinsicHeight(
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
            VerticalDivider(color: Colors.blueAccent, thickness: 2),
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
            VerticalDivider(color: Colors.blueAccent, thickness: 2),
            OutlinedButtonElevated(
              iconData: FontAwesomeIcons.trash,
              label: 'Limpiar',
              onPressed: () {},
            ),
            OutlinedButtonElevated(
              iconData: FontAwesomeIcons.dice,
              label: 'Generar grafo aleatorio',
              onPressed: () {},
            ),
          ],
        ),
      ),
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
