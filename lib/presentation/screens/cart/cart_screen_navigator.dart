import 'package:firebase_e_commerce/presentation/screens/cart/cart_screen.dart';
import 'package:flutter/material.dart';

class CartScreenNavigator extends StatelessWidget {
  static const screenRout = 'cart_screen_navigator';

  const CartScreenNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
        key: cartKey,
        initialRoute: '/',
        onGenerateRoute: (settings) {
          return MaterialPageRoute(
            settings: settings,
            builder: (context) {
              switch (settings.name) {
                case CartScreen.screenRout:
                  return const CartScreen();
              }
              return Container();
            },
          );
        });
  }
}

GlobalKey<NavigatorState> cartKey = GlobalKey<NavigatorState>();
