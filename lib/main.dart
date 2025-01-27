import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_e_commerce/core/light_theme.dart';
import 'package:firebase_e_commerce/main_wrapper.dart';
import 'package:firebase_e_commerce/presentation/blocs/auth/auth_bloc.dart';
import 'package:firebase_e_commerce/presentation/blocs/categories/categories_bloc.dart';
import 'package:firebase_e_commerce/presentation/blocs/product/product_bloc.dart';
import 'package:firebase_e_commerce/presentation/blocs/product_details/product_details_bloc.dart';
import 'package:firebase_e_commerce/presentation/screens/auth/onboarding.dart';
import 'package:firebase_e_commerce/presentation/screens/auth/persist_login.dart';
import 'package:firebase_e_commerce/presentation/screens/auth/splash_screen.dart';
import 'package:firebase_e_commerce/presentation/screens/auth/toggle_loging_register.dart';
import 'package:firebase_e_commerce/presentation/screens/cart/cart_screen_navigator.dart';
import 'package:firebase_e_commerce/presentation/screens/categories_view/category_view.dart';
import 'package:firebase_e_commerce/presentation/screens/home/home_screen.dart';
import 'package:firebase_e_commerce/presentation/screens/home/home_screen_navigator.dart';
import 'package:firebase_e_commerce/presentation/screens/home/prdocut_details_screen.dart';
import 'package:firebase_e_commerce/presentation/screens/profile/profile_screen_navigator.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'core/sl.dart';
import 'domain/repository/auth_repository.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  setUpDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<AuthBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<ProductBloc>(),
        ),    BlocProvider(
          create: (context) => sl<ProductDetailsBloc>(),
        ), BlocProvider(
          create: (context) => sl<CategoriesBloc>(),
        ),
      ],
      child: MaterialApp(
        // onGenerateRoute: (settings) {
        //   return PageRouteBuilder(
        //     pageBuilder: (context, animation, secondaryAnimation) {
        //       switch (settings.name) {
        //         case HomeScreen.screenRout:
        //           return const HomeScreen();
        //         case CategoriesView.screenRout:
        //           return const CategoriesView();
        //         case ProductDetailsScreen.screenRout:
        //           final productId = settings.arguments as String;
        //           return ProductDetailsScreen(
        //             id: productId,
        //           );
        //         default:
        //           return Container(); // Fallback for unknown routes
        //       }
        //     },
        //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
        //       return FadeTransition(
        //         opacity: animation,
        //         child: child,
        //       );
        //     },
        //   );

        // onGenerateRoute: (settings) {
        //   // Handle custom transitions for named routes
        //   switch (settings.name) {
        //     case '/splash_screen':
        //       return FadePageRoute(
        //         child: const SplashScreen(),
        //       );
        //     case '/onboarding_screen':
        //       return FadePageRoute(
        //         child: const Onboarding(),
        //       );
        //     case '/toggle_login_register_screen':
        //       return FadePageRoute(
        //         child: const ToggleLoginRegister(),
        //       );
        //     case '/persist_login':
        //       return FadePageRoute(
        //         child: PersistLogin(
        //           authRepository: sl<AuthRepository>(),
        //         ),
        //       );
        //     default:
        //       return null;
        //   }
        // },
        initialRoute: SplashScreen.screenRout,
        routes: {
          HomeScreenNavigator.screenRout: (context) => const HomeScreenNavigator(),
          CategoriesView.screenRout: (context) => const CategoriesView(),
          MainWrapper.screenRout: (context) => const MainWrapper(),
          CartScreenNavigator.screenRout: (context) => const CartScreenNavigator(),
          ProfileScreenNavigator.screenRout: (context) => const ProfileScreenNavigator(),
          SplashScreen.screenRout: (context) => const SplashScreen(),
          ToggleLoginRegister.screenRout: (context) =>
              const ToggleLoginRegister(),
          HomeScreen.screenRout: (context) => const HomeScreen(),
          PersistLogin.screenRout: (context) => PersistLogin(
                authRepository: sl<AuthRepository>(),
              ),
          Onboarding.screenRout: (context) => const Onboarding(),
        },
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        // theme: AppTheme.theme,
        theme: lightTheme.copyWith(
            textTheme: GoogleFonts.robotoMonoTextTheme(
          Theme.of(context).textTheme,
        )),
      ),
    );
  }
}

class FadePageRoute extends PageRouteBuilder {
  final Widget child;

  FadePageRoute({required this.child})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => child,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 700),
        );
}
