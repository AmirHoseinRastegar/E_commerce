import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_e_commerce/presentation/screens/profile/profile_screen.dart';
import 'package:firebase_e_commerce/presentation/screens/profile/test.dart';
import 'package:flutter/material.dart';

import '../../../core/sl.dart';
import 'edit_info_screen.dart';

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
                case ProfileScreen.screenRout:
                  return  ProfileScreen(fireStore: sl<FirebaseFirestore>(),);
                case ProductUploader.screenRout:
                  return ProductUploader();
                case EditInfoScreen.screenRout:
                  return EditInfoScreen();
              }
              return Container();
            },
          );
        });
  }
}
