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
        key: profileKey,
        onGenerateRoute: (settings) {
          return MaterialPageRoute(
            settings: settings,
            builder: (context) {
              switch (settings.name) {
                case ProfileScreenNavigator.screenRout:
                  return const ProfileScreenNavigator();
              }
              return Container();
            },
          );
        });
  }
}
