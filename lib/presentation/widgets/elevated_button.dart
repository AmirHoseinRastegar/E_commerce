import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final Widget child;
  final  VoidCallback onTap;
  const CustomElevatedButton({super.key,required this.onTap,required this.child});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize:const Size(230, 60),
          backgroundColor: Colors.red.shade700,

        ),
        onPressed: onTap, child: child);
  }
}
