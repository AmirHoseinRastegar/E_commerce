import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_e_commerce/core/light_theme.dart';
import 'package:firebase_e_commerce/presentation/blocs/auth/auth_bloc.dart';
import 'package:firebase_e_commerce/presentation/screens/auth/onboarding.dart';
import 'package:firebase_e_commerce/presentation/screens/auth/persist_login.dart';
import 'package:firebase_e_commerce/presentation/screens/auth/splash_screen.dart';
import 'package:firebase_e_commerce/presentation/screens/auth/toggle_loging_register.dart';
import 'package:firebase_e_commerce/presentation/screens/home/home_screen.dart';

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
      ],
      child: MaterialApp(

        initialRoute: SplashScreen.screenRout,
        routes: {
          SplashScreen.screenRout: (context) => const SplashScreen(),
          ToggleLoginRegister.screenRout: (context) =>
              const ToggleLoginRegister(),
          HomeScreen.screenRout: (context) => const HomeScreen(),
          PersistLogin.screenRout: (context) =>  PersistLogin(authRepository: sl<AuthRepository>(),),
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
