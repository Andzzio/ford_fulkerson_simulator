import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ford_fulkerson_simulator/data/services/windows_manager_service.dart';
import 'package:ford_fulkerson_simulator/providers/service_providers.dart';
import 'package:gap/gap.dart';

class AppTitleBar extends ConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final windowManagerService = ref.read(windowManagerServiceProvider);
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onPanStart: (details) async {
        await windowManagerService.startDragging();
      },
      child: SizedBox(
        width: double.infinity,
        height: 40,
        child: Padding(
          padding: EdgeInsetsGeometry.only(left: 15),
          child: Row(
            children: [
              FaIcon(
                FontAwesomeIcons.diagramProject,
                size: 15,
                color: Colors.blueAccent,
              ),
              Gap(10),
              Text(
                'Ford Fulkerson Simulator',
                style: Theme.of(context).textTheme.bodyLarge
                    ?.copyWith(color: Colors.blueAccent),
              ),
              Spacer(),
              Row(
                children: List.generate(3, (index) {
                  return Center(
                    child: IconButton(
                      icon: _calculateIcon(index),
                      color: _calculateColor(index),
                      onPressed: () async =>
                          _calculateAction(index, windowManagerService),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Color _calculateColor(int index) {
  return switch (index) {
    0 => Colors.greenAccent,
    1 => Colors.orangeAccent,
    2 => Colors.redAccent,
    _ => Colors.transparent,
  };
}

Future<void> _calculateAction(int index, WindowsManagerService service) async {
  return switch (index) {
    0 => service.minimizeWindow(),
    1 => service.maximizeWindow(),
    2 => service.closeWindow(),
    _ => Future.value(),
  };
}

Widget _calculateIcon(int index) {
  return switch (index) {
    0 => FaIcon(FontAwesomeIcons.minus, size: 15),
    1 => FaIcon(FontAwesomeIcons.square, size: 15),
    2 => FaIcon(FontAwesomeIcons.x, size: 15),
    _ => FaIcon(FontAwesomeIcons.circleXmark, size: 15),
  };
}
