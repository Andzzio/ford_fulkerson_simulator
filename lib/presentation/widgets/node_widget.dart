import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ford_fulkerson_simulator/config/theme/app_theme.dart';
import 'package:ford_fulkerson_simulator/presentation/models/node_ui.dart';
import 'package:ford_fulkerson_simulator/presentation/notifiers/graph_mode_notifier.dart';
import 'package:ford_fulkerson_simulator/presentation/notifiers/graph_state_notifier.dart';
import 'package:ford_fulkerson_simulator/presentation/widgets/graph_mode.dart';
import 'package:ford_fulkerson_simulator/src/rust/api/entities/node_core.dart';

class NodeWidget extends ConsumerStatefulWidget {
  const NodeWidget({
    super.key,
    required this.node,
    required this.onTap,
    this.onPanUpdate,
    this.borderColor,
  });
  final NodeUi node;
  final VoidCallback onTap;
  final void Function(DragUpdateDetails)? onPanUpdate;
  final Color? borderColor;

  @override
  ConsumerState<NodeWidget> createState() => _NodeWidgetState();
}

class _NodeWidgetState extends ConsumerState<NodeWidget> {
  bool _isHovered = false;
  bool _isDragging = false;
  @override
  Widget build(BuildContext context) {
    final diameter = widget.node.radius * 2;
    final graphState = ref.watch(graphStateNotifier);
    final mode = ref.watch(graphModeNotifier);
    final isSelectedInMove =
        mode == GraphMode.move && graphState.selectedNode == widget.node;
    final isSelectedInJoin =
        mode == GraphMode.join && graphState.joinSourceNode == widget.node;
    final isVirtual = widget.node.isVirtual;
    final selected = !isVirtual && (isSelectedInMove || isSelectedInJoin);
    final tooltipText = isVirtual
        ? (widget.node.core.nodeType == NodeType.source
            ? 'Origen Ficticio (${widget.node.label})'
            : 'Destino Ficticio (${widget.node.label})')
        : widget.node.label;
    return Tooltip(
      message: tooltipText,
      child: GestureDetector(
        onTap: widget.onTap,
        onPanStart: widget.onPanUpdate != null
            ? (_) => setState(() => _isDragging = true)
            : null,
        onPanUpdate: widget.onPanUpdate,
        onPanEnd: widget.onPanUpdate != null
            ? (_) => setState(() => _isDragging = false)
            : null,
        onPanCancel: widget.onPanUpdate != null
            ? () => setState(() => _isDragging = false)
            : null,
        child: MouseRegion(
          onEnter: (event) {
            setState(() {
              _isHovered = true;
            });
          },
          onExit: (event) {
            setState(() {
              _isHovered = false;
            });
          },
          cursor: isVirtual
              ? (mode == GraphMode.move && widget.onPanUpdate != null
                  ? (_isDragging
                      ? SystemMouseCursors.grabbing
                      : SystemMouseCursors.grab)
                  : SystemMouseCursors.basic)
              : switch (mode) {
                  GraphMode.move => widget.onPanUpdate != null
                      ? (_isDragging
                          ? SystemMouseCursors.grabbing
                          : SystemMouseCursors.grab)
                      : SystemMouseCursors.click,
                  GraphMode.add => SystemMouseCursors.basic,
                  GraphMode.join => SystemMouseCursors.click,
                  GraphMode.delete => SystemMouseCursors.forbidden,
                },
          child: Container(
            width: diameter,
            height: diameter,
            decoration: BoxDecoration(
              color: _isHovered && (!isVirtual || mode == GraphMode.move)
                  ? AppTheme.blueGreyHoverColor
                  : _getNodeColor(widget.node.core.nodeType, isVirtual),
              shape: BoxShape.circle,
              border: Border.all(
                color: widget.borderColor ??
                    (selected ? Colors.orangeAccent : AppTheme.darkBorder),
                width: 3,
              ),
            ),
            child: Center(
              child: Text(
                widget.node.label,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Color _getNodeColor(NodeType type, bool isVirtual) {
    if (isVirtual) {
      return type == NodeType.source
          ? const Color(0xFFB9F6CA)
          : const Color(0xFFFF8A80);
    }
    switch (type) {
      case NodeType.source:
        return Colors.greenAccent;
      case NodeType.sink:
        return Colors.redAccent;
      case NodeType.intermediate:
        return Colors.white;
    }
  }
}
