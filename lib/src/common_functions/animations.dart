import 'package:flutter/material.dart';



void navigateToPage(BuildContext context, Widget page, {Duration duration = const Duration(milliseconds: 200)}) {
  Navigator.pushReplacement(
    context,
    PageRouteBuilder(
      transitionDuration: duration,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    ),
  );
}