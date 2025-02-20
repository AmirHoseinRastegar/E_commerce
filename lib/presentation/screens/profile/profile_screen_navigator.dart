import 'package:firebase_e_commerce/presentation/screens/profile/test.dart';
import 'package:flutter/material.dart';

class ProfileScreenNavigator extends StatefulWidget {
  static const screenRout = '/profile_screen';

  const ProfileScreenNavigator({super.key});

  @override
  State<ProfileScreenNavigator> createState() => _ProfileScreenNavigatorState();
}

GlobalKey<NavigatorState> profileKey = GlobalKey<NavigatorState>();

class _ProfileScreenNavigatorState extends State<ProfileScreenNavigator> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
        initialRoute: '/',
        key: profileKey,
        onGenerateRoute: (settings) {
          return MaterialPageRoute(
            settings: settings,
            builder: (context) {
              switch (settings.name) {
                case ProductUploader.screenRout:
                  return ProductUploader();
              }
              return Container();
            },
          );
        });
  }
}
