import 'package:flutter_riverpod/flutter_riverpod.dart';

// Define the state for the container size
class ContainerSize {
  final double width;
  final double height;

  ContainerSize(this.width, this.height);

  ContainerSize copyWith({double? width, double? height}) {
    return ContainerSize(
      width ?? this.width,
      height ?? this.height,
    );
  }
}

// Define minimum and maximum constraints
const double minWidth = 50.0;
const double minHeight = 50.0;
const double maxWidth = 500.0;
const double maxHeight = 500.0;

// StateNotifier to manage the size with constraints
class ContainerSizeNotifier extends StateNotifier<ContainerSize> {
  ContainerSizeNotifier() : super(ContainerSize(minWidth, minHeight));

  void updateSize(double width, double height) {
    // Apply constraints
    final constrainedWidth = width.clamp(minWidth, maxWidth);
    final constrainedHeight = height.clamp(minHeight, maxHeight);

    state = state.copyWith(width: constrainedWidth, height: constrainedHeight);
  }
}
