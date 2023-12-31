import 'package:flutter/material.dart';

class customButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;

  const customButton({
    Key? key,
    required this.text,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        primary: Colors.green, // Change button color to green
        elevation: 4, // Add a box shadow
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0), // Add rounded corners
        ),
        padding: EdgeInsets.symmetric(
            vertical: 16.0, horizontal: 32.0), // Increase padding
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 18.0,
          color: Colors.black, // Change text color to white
        ),
      ),
    );
  }
}
