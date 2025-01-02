import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const screenRout= 'home_screen';
  static rout() => MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      );

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home Screen',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 29),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [

        ],
      ),
    );
  }
}
