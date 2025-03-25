import 'package:flutter/material.dart';

import 'index.dart';

class SteppingDots extends StatelessWidget {
  final int totalSteps; // Total number of dots
  final int currentStep; // Currently active dot

  SteppingDots({required this.totalSteps, required this.currentStep});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        totalSteps,
        (index) => AnimatedContainer(
          duration: Duration(milliseconds: 300),
          margin: EdgeInsets.symmetric(horizontal: 4),
          width: index == currentStep ? 16 : 8, // Larger size for the active step
          height: index == currentStep ? 16 : 8,
          decoration: BoxDecoration(
            color: index == currentStep
                ? AppColors.blue // Highlight active dot
                : Colors.grey, // Inactive dots
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}