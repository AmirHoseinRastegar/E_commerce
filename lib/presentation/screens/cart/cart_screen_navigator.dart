import 'package:flutter/material.dart';

class CartScreenNavigator extends StatefulWidget {
  static const screenRout = '/cart_screen';

  const CartScreenNavigator({super.key});

  @override
  State<CartScreenNavigator> createState() => _CartScreenNavigatorState();
}

GlobalKey<NavigatorState> cartKey = GlobalKey<NavigatorState>();

class _CartScreenNavigatorState extends State<CartScreenNavigator> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
        key: cartKey,
        onGenerateRoute: (settings) {
          return MaterialPageRoute(
            settings: settings,
            builder: (context) {
              switch (settings.name) {
                case CartScreenNavigator.screenRout:
                  return const CartScreenNavigator();
              }
              return Container();
            },
          );
        });
  }
}
