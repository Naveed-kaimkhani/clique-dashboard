import 'package:flutter/material.dart';

class ProfileContainer extends StatelessWidget {
  final String imagePath;

  const ProfileContainer({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 76, // Adjust width as needed
      height: 76, // Adjust height as needed
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16             ), // Rounded corners
        color: const Color.fromARGB(255, 225, 223, 230), // Background color
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.black.withOpacity(0.1),
        //     blurRadius: 1,
        //     spreadRadius: 1,
        //   ),
        // ],
      ),
      child: Image.asset(
        imagePath,
        fit: BoxFit.cover,
      ),
    );
  }
}
