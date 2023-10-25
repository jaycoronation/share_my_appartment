import 'package:flutter/material.dart';

/// Mediates indicator building and animation.
class Indicator {
  /// [normalController] Animation controller when state changes to normal
  /// [highlightedController] Animation controller when state changes to selected
  /// [widget] Indicator widget
  /// [builder] Widgetbuilder object
  /// [index] Determine index on the stack
  Indicator({
    required this.normalController,
    required this.highlightedController,
    this.index = 0,
  });

  final AnimationController normalController;
  final AnimationController highlightedController;
  final int index;

  void dispose() {
    normalController.dispose();
    highlightedController.dispose();
  }
}
