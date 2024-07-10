import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'model.dart';

final gridProvider = StateNotifierProvider<GridState, GridModel>((ref) {
  return GridState();
});
