import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  static const screenRout = '/cart_screen';

  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

GlobalKey<NavigatorState> cartKey = GlobalKey<NavigatorState>();

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
        key: cartKey,
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
