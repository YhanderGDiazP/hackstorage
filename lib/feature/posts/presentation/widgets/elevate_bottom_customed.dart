import 'package:flutter/material.dart';

class CustomPElevateButtom extends StatelessWidget {
  final String label;
  final void Function()? onPressed;
  final double heigth;
  final double width;
  const CustomPElevateButtom({
    super.key,
    required this.label,
    required this.onPressed,
    required this.heigth,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: heigth,
      width: width,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
              side: const BorderSide(color: Colors.white, width: 2),
            ),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
