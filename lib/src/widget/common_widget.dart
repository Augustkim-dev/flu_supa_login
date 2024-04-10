import 'package:flutter/material.dart';

class JunElevatedButton extends StatelessWidget {
  String title;
  Function onPressed;
  Color? fontColor;
  Color? backgroundColor;

  JunElevatedButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.fontColor = Colors.white,
    this.backgroundColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressed.call(),
      child: Text(title,
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w600, color: fontColor)),
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            4,
          ),
        ),
      ),
    );
  }
}
