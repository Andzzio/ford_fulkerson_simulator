import 'package:flutter/foundation.dart';
import 'package:window_manager/window_manager.dart';

class WindowsManagerService {
  Future<void> minimizeWindow() async {
    if (kIsWeb) return;
    await WindowManager.instance.minimize();
  }

  Future<void> maximizeWindow() async {
    if (kIsWeb) return;
    if (await WindowManager.instance.isMaximized()) {
      await WindowManager.instance.unmaximize();
    } else {
      await WindowManager.instance.maximize();
    }
  }

  Future<void> closeWindow() async {
    if (kIsWeb) return;
    await WindowManager.instance.close();
  }

  Future<void> startDragging() async {
    if (kIsWeb) return;
    await WindowManager.instance.startDragging();
  }
}
