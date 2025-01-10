import 'dart:async';

import 'package:firebase_e_commerce/core/shared_preferences.dart';
import 'package:firebase_e_commerce/presentation/screens/auth/onboarding.dart';
import 'package:firebase_e_commerce/presentation/screens/auth/persist_login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const screenRout = '/splash_screen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  Animation<double>? _fadeAnimation;
  bool isAnimated = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this, // Animation duration
    );
    _fadeAnimation =
        Tween<double>(begin: 1.0, end: 0.0).animate(_animationController!);
    Future.delayed(const Duration(seconds: 2), () async {
      await _animationController!.forward().then((_) async {
        if (await SharedPreferencesHelper.getOnboarding()) {
          return Navigator.pushNamedAndRemoveUntil(
            context,
            PersistLogin.screenRout,
            (route) => false,
          );
        } else {
          return Navigator.pushNamedAndRemoveUntil(
            context,
            Onboarding.screenRout,
            (route) => false,
          );
        }
      });
    });
    // Future.delayed(const Duration(milliseconds: 100), () {
    //   setState(() {
    //     isAnimated = true;
    //   });
    // });
    // Future.delayed(const Duration(milliseconds: 2500), () async {
    //   if (await SharedPreferencesHelper.getOnboarding()) {
    //     return Navigator.pushNamedAndRemoveUntil(
    //       context,
    //       PersistLogin.screenRout,
    //       (route) => false,
    //     );
    //   } else {
    //     return Navigator.pushNamedAndRemoveUntil(
    //       context,
    //       Onboarding.screenRout,
    //       (route) => false,
    //     );
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set your splash screen background color
      body: FadeTransition(
        opacity: _fadeAnimation!,
        child: Center(
          child: Image.asset('assets/img/splash_icon.png',height: 130,),
        ),
      ),
    );
  }
}
