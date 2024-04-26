import 'package:flutter/material.dart';

class SquareButton extends StatelessWidget {
  final VoidCallback onPressed;
  final double size;
  final Color color;
  final Widget child;

  const SquareButton({
    Key? key,
    required this.onPressed,
    this.size = 55.0,
    this.color = Colors.blue,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 55,
      height: 55,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          minimumSize: Size(size, size),
          backgroundColor: color,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
            side: const BorderSide(color: Colors.blueGrey, width: 5),
          ),
        ),
        child: Center(
          child: child,
        ),
      ),
    );
  }
}