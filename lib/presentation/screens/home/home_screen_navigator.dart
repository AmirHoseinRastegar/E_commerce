import 'package:firebase_e_commerce/presentation/screens/home/all_products_screen.dart';
import 'package:firebase_e_commerce/presentation/screens/home/home_screen.dart';
import 'package:firebase_e_commerce/presentation/screens/home/prdocut_details_screen.dart';
import 'package:firebase_e_commerce/presentation/screens/home/special_offers_screen.dart';
import 'package:firebase_e_commerce/presentation/screens/search/search_screen.dart';
import 'package:flutter/material.dart';

class HomeScreenNavigator extends StatelessWidget {
  static const screenRout = 'home_screen_navigator';

  const HomeScreenNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
        key: homeKey,
        onGenerateRoute: (settings) {
          return MaterialPageRoute(
            settings: settings,
            builder: (context) {
              switch (settings.name) {
                case HomeScreen.screenRout:
                  return const HomeScreen();
                case AllProductsScreen.screenRout:
                  return const AllProductsScreen();
                case SpecialOffersScreen.screenRout:
                  return const SpecialOffersScreen();
                case SearchScreen.screenRout:
                  return const SearchScreen();
                case ProductDetailsScreen.screenRout:
                  final productId = settings.arguments as String;
                  return ProductDetailsScreen(
                    id: productId,
                  );
              }
              return Container();
            },
          );
        });
  }
}

GlobalKey<NavigatorState> homeKey = GlobalKey<NavigatorState>();
