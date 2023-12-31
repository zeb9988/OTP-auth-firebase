import 'package:flutter/material.dart';

class greenintroWidget extends StatelessWidget {
  const greenintroWidget({Key? key});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CurvedClipper(), // Custom clipper
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.4,
        decoration: BoxDecoration(
          color: Colors.green, // Change color to your desired color
        ),
        child: Image.asset('assets/logo.png'),
      ),
    );
  }
}

class CurvedClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height * 0.85); // Start at the bottom-left corner
    path.quadraticBezierTo(size.width / 2, size.height, size.width,
        size.height * 0.85); // Define the curve
    path.lineTo(size.width, 0); // Line to the bottom-right corner
    path.close(); // Close the path

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false; // This clipper is static and doesn't need to be updated
  }
}
