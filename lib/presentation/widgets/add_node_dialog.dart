import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ford_fulkerson_simulator/presentation/notifiers/graph_state_notifier.dart';
import 'package:ford_fulkerson_simulator/presentation/widgets/outlined_button_elevated.dart';
import 'package:ford_fulkerson_simulator/src/rust/api/entities/node_core.dart';

class AddNodeDialog extends ConsumerStatefulWidget {
  const AddNodeDialog({super.key, required this.position});
  final Offset position;

  @override
  ConsumerState<AddNodeDialog> createState() => _AddNodeDialogState();
}

class _AddNodeDialogState extends ConsumerState<AddNodeDialog> {
  late final TextEditingController _controller;
  NodeType _selectedType = NodeType.intermediate;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit(String suggestedLabel) {
    final text = _controller.text.trim().toUpperCase();
    final effectiveLabel = text.isNotEmpty ? text : suggestedLabel;
    ref
        .read(graphStateNotifier.notifier)
        .addNode(
          position: widget.position,
          label: effectiveLabel,
          nodeType: _selectedType,
        );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final graphNotifier = ref.read(graphStateNotifier.notifier);
    final nextId = graphNotifier.getNextAvailableId();
    final suggestedLabel = graphNotifier.getSuggestedLabel(nextId);

    return AlertDialog(
      title: const Text('Agregar Nodo'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _controller,
              autofocus: true,
              maxLength: 1,
              inputFormatters: [
                LengthLimitingTextInputFormatter(1),
                FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]')),
                _UpperCaseTextFormatter(),
              ],
              decoration: InputDecoration(
                labelText: 'Etiqueta',
                hintText: suggestedLabel,
                counterText: '',
              ),
              onSubmitted: (_) => _submit(suggestedLabel),
            ),
            const SizedBox(height: 20),
            const Text('Tipo de Nodo:'),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 12,
              children: [
                _buildTypeButton(
                  message: 'Fuente',
                  iconData: FontAwesomeIcons.arrowRightFromBracket,
                  type: NodeType.source,
                ),
                _buildTypeButton(
                  message: 'Intermedio',
                  iconData: FontAwesomeIcons.arrowsLeftRight,
                  type: NodeType.intermediate,
                ),
                _buildTypeButton(
                  message: 'Sumidero',
                  iconData: FontAwesomeIcons.arrowRightToBracket,
                  type: NodeType.sink,
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
        OutlinedButtonElevated(
          onPressed: () => _submit(suggestedLabel),
          child: const Text('Crear'),
        ),
      ],
    );
  }

  Widget _buildTypeButton({
    required String message,
    required FaIconData iconData,
    required NodeType type,
  }) {
    final selected = type == _selectedType;
    return Badge(
      isLabelVisible: selected,
      backgroundColor: Colors.greenAccent,
      label: const FaIcon(FontAwesomeIcons.check, size: 10),
      child: Tooltip(
        message: message,
        child: IconButton(
          icon: FaIcon(iconData),
          onPressed: () {
            setState(() {
              _selectedType = type;
            });
          },
        ),
      ),
    );
  }
}

class _UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
