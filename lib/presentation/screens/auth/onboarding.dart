import 'package:firebase_e_commerce/core/shared_preferences.dart';
import 'package:firebase_e_commerce/presentation/screens/auth/persist_login.dart';
import 'package:flutter/material.dart';

import '../../widgets/onboarding_widget.dart';
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
      title: 'Discover Your Perfect Finds',
      description:
          'Shop from a wide range of products tailored just for you. From daily essentials to exclusive collections, we’ve got it all in one place',
      image: 'assets/img/onboarding1.jpg',
    ),
    OnboardingWidget(
      title: 'Fast, Easy, and Secure',
      description:
          'Enjoy a smooth shopping experience with easy navigation, secure payments, and quick checkouts—all at your fingertips.',
      image: 'assets/img/onboarding2.jpg',
    ),
    OnboardingWidget(
      title: 'Shop More, Earn More',
      description:
          'Unlock exclusive discounts, earn reward points, and enjoy personalized offers. Start shopping and get rewarded today!',
      image: 'assets/img/onboarding3.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
