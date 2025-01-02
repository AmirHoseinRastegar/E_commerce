import 'dart:async';

import 'package:firebase_e_commerce/domain/repository/auth_repository.dart';
import 'package:firebase_e_commerce/presentation/screens/auth/persist_login.dart';
import 'package:firebase_e_commerce/presentation/screens/auth/toggle_loging_register.dart';
import 'package:flutter/material.dart';

import '../../../core/sl.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const screenRout = 'splash_screen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
   bool isAnimated=false;

  navigateAfter() {
    Navigator.pushAndRemoveUntil(
      context,
    MaterialPageRoute(builder: (context)=>PersistLogin(authRepository: sl<AuthRepository>(),)) ,
          (route) => false,
    );
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        isAnimated = true;
      });
    });
    Future.delayed(const Duration(milliseconds: 2500), () {
      return Navigator.pushNamedAndRemoveUntil(
        context,
        ToggleLoginRegister.screenRout,
            (route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Stack(
        children:[
          AnimatedPositioned(
            duration: const Duration(seconds: 1),
            curve: Curves.easeInOut,
            top: isAnimated ? MediaQuery.of(context).size.height / 3 : 0,
            left: MediaQuery.of(context).size.width / 2 - 50,
            child: AnimatedOpacity(
              opacity: isAnimated ? 1.0 : 0.0,
              duration: const Duration(seconds: 1),
              child: const Icon(
                Icons.front_loader ,
                size: 100,
              ),
            ),
          ),

        ]
      ),
    );
  }
}
