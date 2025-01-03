import 'dart:async';

import 'package:firebase_e_commerce/core/shared_preferences.dart';
import 'package:firebase_e_commerce/presentation/screens/auth/onboarding.dart';
import 'package:firebase_e_commerce/presentation/screens/auth/persist_login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const screenRout = 'splash_screen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isAnimated = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        isAnimated = true;
      });
    });
    Future.delayed(const Duration(milliseconds: 2500), () async {
      if (await SharedPreferencesHelper.getOnboarding()) {
        return Navigator.pushNamedAndRemoveUntil(
          context,
          PersistLogin.screenRout,
          (route) => false,
        );
      }else{
        return Navigator.pushNamedAndRemoveUntil(
          context,
          Onboarding.screenRout,
          (route) => false,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        AnimatedPositioned(
          duration: const Duration(seconds: 1),
          curve: Curves.easeInOut,
          top: isAnimated ? MediaQuery.of(context).size.height / 3 : 0,
          left: MediaQuery.of(context).size.width / 2 - 50,
          child: AnimatedOpacity(
            opacity: isAnimated ? 1.0 : 0.0,
            duration: const Duration(seconds: 1),
            child: const Icon(
              Icons.front_loader,
              size: 100,
            ),
          ),
        ),
      ]),
    );
  }
}
