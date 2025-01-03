import 'package:firebase_e_commerce/core/shared_preferences.dart';
import 'package:firebase_e_commerce/presentation/screens/auth/persist_login.dart';
import 'package:flutter/material.dart';

import '../../widgets/onboarding.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Onboarding extends StatefulWidget {
  static const screenRout = 'onboarding_screen';

  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  int currentIndex = 0;
  final pageController = PageController();
  List<OnboardingWidget> pages = const [
    OnboardingWidget(
      title: 'Shopping From Everywhere',
      description: 'as easy as drinking water',
      image: 'image1',
    ),
    OnboardingWidget(
      title: 'Best Offers Around',
      description: 'Find great deals and save more',
      image: 'image2',
    ),
    OnboardingWidget(
      title: 'Fast Delivery',
      description: 'Delivered to your doorstep in no time',
      image: 'image3',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        SafeArea(
          child: PageView.builder(
              onPageChanged: (value) {
                setState(() {
                  currentIndex = value;
                });
              },
              itemCount: pages.length,
              controller: pageController,
              itemBuilder: (context, index) {
                return pages[index];
              }),
        ),
        Positioned(
          bottom: 15,
          left: 0,
          right: 0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SmoothPageIndicator(
                  controller: pageController,
                  count: pages.length,
                  effect: const ExpandingDotsEffect(),
                  onDotClicked: (index) {
                    pageController.animateToPage(index,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn);
                  }),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                  onPressed: () {
                    if (currentIndex < pages.length - 1) {
                      pageController.animateToPage(currentIndex + 1,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.decelerate);
                    } else {
                      SharedPreferencesHelper.setOnboarding(true);
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          PersistLogin.screenRout, (route) => false);
                    }
                  },
                  child: Text(
                      currentIndex == pages.length - 1 ? 'let\'s go' : 'Next')),
            ],
          ),
        )
      ]),
    );
  }
}
