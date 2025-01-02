import 'package:flutter/material.dart';

Route<dynamic> createCustomRoute(Widget page) {
  return PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 1000),
    reverseTransitionDuration: const Duration(milliseconds: 1000),
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const beginOffset = Offset(3.0, -3.0); // Top-right
      const endOffset = Offset.zero; // Center
      const curve = Curves.easeInOut;

      var tween = Tween(begin: beginOffset, end: endOffset)
          .chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);

      var reverseTween = Tween(begin: Offset.zero, end: const Offset(-3.0, 3.0)); // Bottom-left
      var reverseAnimation = secondaryAnimation.drive(reverseTween);

      return SlideTransition(
        position: animation.status == AnimationStatus.reverse
            ? reverseAnimation
            : offsetAnimation,
        child: child,
      );
    },
  );
}