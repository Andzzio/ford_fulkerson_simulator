import 'package:window_manager/window_manager.dart';

class WindowsManagerService {
  Future<void> minimizeWindow() async {
    await WindowManager.instance.minimize();
  }

  Future<void> maximizeWindow() async {
    if (await WindowManager.instance.isMaximized()) {
      await WindowManager.instance.unmaximize();
    } else {
      await WindowManager.instance.maximize();
    }
  }

  Future<void> closeWindow() async {
    await WindowManager.instance.close();
  }

  Future<void> startDragging() async {
    await WindowManager.instance.startDragging();
  }
}
