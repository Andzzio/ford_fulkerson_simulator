import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ford_fulkerson_simulator/presentation/models/node_ui.dart';
import 'package:ford_fulkerson_simulator/presentation/notifiers/graph_state_notifier.dart';
import 'package:ford_fulkerson_simulator/presentation/widgets/outlined_button_elevated.dart';

class AddEdgeDialog extends ConsumerStatefulWidget {
  const AddEdgeDialog({
    super.key,
    required this.from,
    required this.to,
  });

  final NodeUi from;
  final NodeUi to;

  @override
  ConsumerState<AddEdgeDialog> createState() => _AddEdgeDialogState();
}

class _AddEdgeDialogState extends ConsumerState<AddEdgeDialog> {
  late final TextEditingController _controller;
  String? _errorText;

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

  void _submit() {
    final text = _controller.text.trim();
    final capacity = int.tryParse(text);
    if (capacity == null || capacity <= 0) {
      setState(() {
        _errorText = 'Ingresa una capacidad mayor a 0';
      });
      return;
    }
    ref.read(graphStateNotifier.notifier).addEdge(
          from: widget.from,
          to: widget.to,
          capacity: capacity,
        );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Conectar ${widget.from.label} → ${widget.to.label}'),
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
            ref.read(graphStateNotifier.notifier).clearJoinSource();
            Navigator.of(context).pop();
          },
          child: const Text('Cancelar'),
        ),
        OutlinedButtonElevated(
          onPressed: _submit,
          child: const Text('Conectar'),
        ),
      ],
    );
  }
}
