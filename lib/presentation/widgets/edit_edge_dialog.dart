import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ford_fulkerson_simulator/presentation/models/edge_ui.dart';
import 'package:ford_fulkerson_simulator/presentation/notifiers/graph_state_notifier.dart';
import 'package:ford_fulkerson_simulator/presentation/widgets/outlined_button_elevated.dart';

class EditEdgeDialog extends ConsumerStatefulWidget {
  const EditEdgeDialog({
    super.key,
    required this.edge,
  });

  final EdgeUi edge;

  @override
  ConsumerState<EditEdgeDialog> createState() => _EditEdgeDialogState();
}

class _EditEdgeDialogState extends ConsumerState<EditEdgeDialog> {
  late final TextEditingController _controller;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: widget.edge.core.capacity.toString(),
    );
    _controller.selection = TextSelection(
      baseOffset: 0,
      extentOffset: _controller.text.length,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    final text = _controller.text.trim();
    final capacity = int.tryParse(text);
    if (capacity == null || capacity <= 0) {
      setState(() {
        _errorText = 'Ingresa una capacidad mayor a 0';
      });
      return;
    }
    ref.read(graphStateNotifier.notifier).updateEdgeCapacity(
          edgeId: widget.edge.core.id,
          capacity: capacity,
        );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Editar Capacidad ${widget.edge.from.label} → ${widget.edge.to.label}',
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _controller,
              autofocus: true,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(4),
              ],
              decoration: InputDecoration(
                labelText: 'Capacidad',
                hintText: 'Ej. 10',
                errorText: _errorText,
              ),
              onSubmitted: (_) => _submit(),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancelar'),
        ),
        OutlinedButtonElevated(
          onPressed: _submit,
          child: const Text('Guardar'),
        ),
      ],
    );
  }
}
