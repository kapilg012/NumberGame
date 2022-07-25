import 'package:flutter/material.dart';

class Player {
  final String name;
  double? number = 0;
  bool hasWon = false;

  Player({required this.name, this.number = 0, this.hasWon = false});
}
