import 'package:flutter_riverpod/flutter_riverpod.dart';

class ViewportController {
  void Function()? onCenterGraph;
  void Function(double scale)? onSetZoom;

  void centerGraph() => onCenterGraph?.call();
  void setZoom(double scale) => onSetZoom?.call(scale);
}

final viewportControllerProvider = Provider<ViewportController>((ref) {
  return ViewportController();
});
