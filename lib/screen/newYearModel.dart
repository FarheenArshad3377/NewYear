import 'dart:math';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class Newyearmodel extends BaseViewModel {
  late ConfettiController _confettiController;
  bool isTimerFinished = false; // Flag to control when to show the text

  ConfettiController get confettiController => _confettiController;

  // Initialize ConfettiController
  void initializeConfetti() {
    _confettiController = ConfettiController(duration: const Duration(seconds: 10));
  }

  // Dispose ConfettiController to avoid memory leaks
  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  // Method to handle when the timer ends
  void timerEnded() {
    isTimerFinished = true; // Update the flag
    _confettiController.play(); // Start the confetti animation
    notifyListeners(); // Notify listeners to rebuild the UI
  }

  // Method to draw a star-shaped particle path for confetti
  Path drawStar(Size size) {
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }
}
