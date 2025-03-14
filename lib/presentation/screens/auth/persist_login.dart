import 'package:firebase_e_commerce/core/loading.dart';
import 'package:firebase_e_commerce/domain/repository/auth_repository.dart';
import 'package:firebase_e_commerce/main_wrapper.dart';
import 'package:firebase_e_commerce/presentation/screens/auth/toggle_loging_register.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/persist_login_cubit/persist_login_cubit.dart';

class PersistLogin extends StatelessWidget {
  final AuthRepository authRepository;
  static const screenRout='/persist_login';
  const PersistLogin({super.key, required this.authRepository});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PersistLoginCubit(authRepository: authRepository)..persistLogin(),
      child: Scaffold(body: BlocBuilder<PersistLoginCubit, PersistLoginState>(
        builder: (BuildContext context, PersistLoginState state) {
          if (state is Authenticated) {
            return const MainWrapper();
          }
          if (state is UnAuthenticated) {
            return const ToggleLoginRegister();
          }
          return const Center(child: LoadingPage());
        },
      )),
    );
  }
}
