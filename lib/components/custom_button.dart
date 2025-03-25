import 'package:flutter/material.dart';


class OnboardButton extends StatelessWidget {
  final VoidCallback onTap; // Function to be passed as an argument

  const OnboardButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onTap,
      child: Container(
        height: 106,
        width: 106,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
                Color(0xFFFFF5DA),
              // Color 2: #8CD6E5
              Color(0xFFBEE3E0), // Color 3: #BEE3E0
             // Color 4: #FFF5DA // Color 1: #6BCDE8
              Color(0xFF8CD6E5),
              
               Color(0xFF6BCDE8),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(37), // Circular border radius
        ),
        child:
         Icon(Icons.arrow_forward, size: 45,)
      ),
    );
  }
}