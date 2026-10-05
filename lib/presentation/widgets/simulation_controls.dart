import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ford_fulkerson_simulator/presentation/notifiers/graph_state_notifier.dart';
import 'package:ford_fulkerson_simulator/presentation/notifiers/simulation_notifier.dart';
import 'package:ford_fulkerson_simulator/presentation/widgets/app_info_badge.dart';
import 'package:ford_fulkerson_simulator/presentation/widgets/outlined_button_elevated.dart';
import 'package:ford_fulkerson_simulator/presentation/widgets/simulation_status.dart';

class SimulationControls extends ConsumerWidget {
  const SimulationControls({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final simulationState = ref.watch(simulationNotifier);
    final simulationStateNotifier = ref.read(simulationNotifier.notifier);
    final graphState = ref.watch(graphStateNotifier);

    return Row(
      spacing: 10,
      children: [
        Tooltip(
          message: 'Atrás',
          child: OutlinedButtonElevated.iconOnly(
            iconData: FontAwesomeIcons.angleLeft,
            onPressed: simulationStateNotifier.canStepBackward
                ? () {
                    simulationStateNotifier.stepBackward();
                  }
                : null,
          ),
        ),
        Tooltip(
          message: 'Reproducir',
          child: OutlinedButtonElevated.iconOnly(
            iconData: FontAwesomeIcons.play,
            isActive: simulationState.status == SimulationStatus.playing,
            onPressed: simulationStateNotifier.canPlay
                ? () {
                    simulationStateNotifier.play();
                  }
                : null,
          ),
        ),
        Tooltip(
          message: 'Pausar',
          child: OutlinedButtonElevated.iconOnly(
            iconData: FontAwesomeIcons.pause,
            isActive: simulationState.status == SimulationStatus.paused,
            onPressed: simulationState.status == SimulationStatus.playing
                ? () {
                    simulationStateNotifier.pause();
                  }
                : null,
          ),
        ),
        Tooltip(
          message: 'Finalizar',
          child: OutlinedButtonElevated.iconOnly(
            iconData: FontAwesomeIcons.anglesRight,
            isActive: simulationState.status == SimulationStatus.finished,
            onPressed: simulationStateNotifier.canStepForward
                ? () {
                    simulationStateNotifier.fastForward();
                  }
                : null,
          ),
        ),
        Tooltip(
          message: 'Adelante',
          child: OutlinedButtonElevated.iconOnly(
            iconData: FontAwesomeIcons.angleRight,
            onPressed: simulationStateNotifier.canStepForward
                ? () {
                    simulationStateNotifier.pause();
                    simulationStateNotifier.stepForward();
                  }
                : null,
          ),
        ),
        AppInfoBadge.text(
          text:
              'Paso ${simulationState.currentStep} / ${simulationState.totalSteps}',
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 10),
        ),
        AppInfoBadge.text(
          text:
              'Flujo: ${simulationState.getTotalSinkFlow(graphState.nodes, graphState.edges)} / ${simulationState.maxFlow}',
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 10),
        ),
      ],
    );
  }
}
