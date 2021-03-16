import 'dart:math';
import 'package:flutter/material.dart';

MaterialColor randomColorPicker() {
  return Colors.primaries[Random().nextInt(Colors.primaries.length)];
}
