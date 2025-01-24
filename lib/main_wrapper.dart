import 'package:firebase_e_commerce/presentation/blocs/product/product_bloc.dart';
import 'package:firebase_e_commerce/presentation/screens/cart/cart_screen_navigator.dart';
import 'package:firebase_e_commerce/presentation/screens/home/home_screen.dart';
import 'package:firebase_e_commerce/presentation/screens/home/home_screen_navigator.dart';
import 'package:firebase_e_commerce/presentation/screens/profile/profile_screen_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainWrapper extends StatefulWidget {
  static const screenRout = 'main_wrapper';

  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

int homeIndex = 0;
int cartIndex = 1;
int profileIndex = 2;

class _MainWrapperState extends State<MainWrapper> {
  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(FetchProductEvent());
  }

  final List<int> history = [];

  final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    homeKey,
    cartKey,
    profileKey,
  ];

  Future<bool> onPopInvoked(bool didPop) {
    if (_navigatorKeys[selectedIndex].currentState!.canPop()) {
      _navigatorKeys[selectedIndex]
          .currentState!
          .pop(_navigatorKeys[selectedIndex].currentContext);
    } else if (history.isNotEmpty) {
      setState(() {
        selectedIndex = history.last;
      });
      history.removeLast();
      false;
    } else {
      SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop');
    }
    return Future.value(false);
  }

  int selectedIndex = homeIndex;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: onPopInvoked,
      child: Scaffold(
        body: IndexedStack(
          index: selectedIndex,
          children: const [
            HomeScreenNavigator(),
            CartScreenNavigator(),
            ProfileScreenNavigator(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.red,
          unselectedItemColor: Colors.grey,
          currentIndex: selectedIndex,
          onTap: (index) {
            setState(() {
              history.remove(selectedIndex);
              history.add(selectedIndex);
              selectedIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'Cart',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
