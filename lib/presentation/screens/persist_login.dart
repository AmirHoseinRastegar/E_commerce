import 'package:firebase_e_commerce/domain/repository/auth_repository.dart';
import 'package:firebase_e_commerce/presentation/screens/home_screen.dart';
import 'package:firebase_e_commerce/presentation/screens/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/persist_login_cubit/persist_login_cubit.dart';

class PersistLogin extends StatelessWidget {
  final AuthRepository authRepository;

  const PersistLogin({super.key, required this.authRepository});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PersistLoginCubit(authRepository: authRepository)..persistLogin(),
      child: Scaffold(body: BlocBuilder<PersistLoginCubit, PersistLoginState>(
        builder: (BuildContext context, PersistLoginState state) {
          if (state is Authenticated) {
            return const HomeScreen();
          }
          if (state is UnAuthenticated) {
            return const LoginPage();
          }
          return Container();
        },
      )),
    );
  }
}
