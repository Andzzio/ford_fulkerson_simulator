import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ford_fulkerson_simulator/presentation/models/simulation_state.dart';
import 'package:ford_fulkerson_simulator/presentation/widgets/simulation_status.dart';
import 'package:ford_fulkerson_simulator/providers/core_providers.dart';
import 'package:ford_fulkerson_simulator/src/rust/api/entities/graph_core.dart';

class SimulationNotifier extends Notifier<SimulationState> {
  Timer? _timer;

  @override
  SimulationState build() {
    ref.onDispose(() {
      _timer?.cancel();
    });
    return SimulationState();
  }

  bool get isStopped => state.status == SimulationStatus.stopped;
  bool get isPlaying => state.status == SimulationStatus.playing;
  bool get isPaused => state.status == SimulationStatus.paused;
  bool get isFinished => state.status == SimulationStatus.finished;
  bool get isSimulating => !isStopped;
  bool get canStepBackward => isSimulating && state.currentStep > 1;
  bool get canStepForward =>
      isSimulating && state.currentStep < state.totalSteps;
  bool get canPlay =>
      isSimulating &&
      !isPlaying &&
      !isFinished &&
      state.currentStep < state.totalSteps;

  void startSimulation(GraphCore graph) {
    _timer?.cancel();
    final result = ref.read(runFordFulkersonProvider)(graph);
    final initialStep = result.events.isNotEmpty ? 1 : 0;
    state = SimulationState(
      status: SimulationStatus.paused,
      events: result.events,
      maxFlow: result.maxFlow,
      currentStep: initialStep,
    );
  }

  void stopSimulation() {
    _timer?.cancel();
    state = SimulationState(
      status: SimulationStatus.stopped,
      events: const [],
      maxFlow: 0,
      currentStep: 0,
    );
  }

  void startPlayback(Duration stepDuration) {
    _timer?.cancel();
    if (!canStepForward) return;
    state = state.copyWith(status: SimulationStatus.playing);
    _timer = Timer.periodic(stepDuration, (timer) {
      if (canStepForward) {
        stepForward();
        if (state.currentStep >= state.totalSteps) {
          _timer?.cancel();
          state = state.copyWith(status: SimulationStatus.finished);
        }
      } else {
        _timer?.cancel();
        state = state.copyWith(status: SimulationStatus.finished);
      }
    });
  }

  void play([Duration stepDuration = const Duration(milliseconds: 300)]) {
    startPlayback(stepDuration);
  }

  void fastForward([Duration stepDuration = const Duration(milliseconds: 60)]) {
    startPlayback(stepDuration);
  }

  void pause() {
    _timer?.cancel();
    state = state.copyWith(status: SimulationStatus.paused);
  }

  void changeStatus(SimulationStatus newStatus) {
    state = state.copyWith(status: newStatus);
  }

  void stepBackward() {
    _timer?.cancel();
    if (canStepBackward) {
      state = state.copyWith(
        currentStep: state.currentStep - 1,
        status: SimulationStatus.paused,
      );
    }
  }

  void stepForward() {
    if (canStepForward) {
      final next = state.currentStep + 1;
      state = state.copyWith(
        currentStep: next,
        status: next >= state.totalSteps
            ? SimulationStatus.finished
            : state.status,
      );
    }
  }

  void jumpToEnd() {
    _timer?.cancel();
    if (canStepForward) {
      state = state.copyWith(
        currentStep: state.totalSteps,
        status: SimulationStatus.finished,
      );
    }
  }
}

final simulationNotifier =
    NotifierProvider<SimulationNotifier, SimulationState>(
      SimulationNotifier.new,
    );
