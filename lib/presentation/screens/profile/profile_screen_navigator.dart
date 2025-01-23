import 'package:firebase_e_commerce/main_wrapper.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  static const screenRout = '/profile_screen';

  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

GlobalKey<NavigatorState> profileKey = GlobalKey<NavigatorState>();

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
        key: profileKey,
        onGenerateRoute: (settings) {
          return MaterialPageRoute(
            settings: settings,
            builder: (context) {
              switch (settings.name) {
                case ProfileScreen.screenRout:
                  return const ProfileScreen();
              }
              return Container();
            },
          );
        });
  }
}
