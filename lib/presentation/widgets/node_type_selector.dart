import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ford_fulkerson_simulator/presentation/notifiers/graph_state_notifier.dart';
import 'package:ford_fulkerson_simulator/presentation/widgets/app_info_badge.dart';
import 'package:ford_fulkerson_simulator/src/rust/api/entities/node_core.dart';

class NodeTypeSelector extends ConsumerWidget {
  const NodeTypeSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedNode = ref.watch(
      graphStateNotifier.select((state) => state.selectedNode),
    );
    if (selectedNode == null) return SizedBox.shrink();
    final currentType = selectedNode.core.nodeType;
    final graphNotifier = ref.read(graphStateNotifier.notifier);
    return Column(
      spacing: 10,
      children: [
        AppInfoBadge.text(text: 'Tipo de Nodo'),
        Row(
          spacing: 10,
          children: [
            _buildTypeButton(
              message: 'Fuente',
              iconData: FontAwesomeIcons.arrowRightFromBracket,
              onPressed: () {
                graphNotifier.updateNodeType(NodeType.source);
              },
              type: NodeType.source,
              currentType: currentType,
            ),
            _buildTypeButton(
              message: 'Intermedio',
              iconData: FontAwesomeIcons.arrowsLeftRight,
              onPressed: () {
                graphNotifier.updateNodeType(NodeType.intermediate);
              },
              type: NodeType.intermediate,
              currentType: currentType,
            ),
            _buildTypeButton(
              message: 'Sumidero',
              iconData: FontAwesomeIcons.arrowRightToBracket,
              onPressed: () {
                graphNotifier.updateNodeType(NodeType.sink);
              },
              type: NodeType.sink,
              currentType: currentType,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTypeButton({
    String? message,
    required FaIconData iconData,
    required VoidCallback onPressed,
    required NodeType type,
    required NodeType currentType,
  }) {
    final selected = type == currentType;
    return Badge(
      isLabelVisible: selected,
      backgroundColor: Colors.greenAccent,
      label: FaIcon(FontAwesomeIcons.check, size: 10),
      child: Tooltip(
        message: message,
        child: IconButton(icon: FaIcon(iconData), onPressed: onPressed),
      ),
    );
  }
}
