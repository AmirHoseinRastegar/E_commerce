import 'package:firebase_e_commerce/presentation/widgets/carousel_slider_widget.dart';
import 'package:flutter/material.dart';

class TestScreen extends StatefulWidget {
  static const screenRout = 'test_screen';
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CarouselSliderWidget(),
      ),
    );
  }
}
