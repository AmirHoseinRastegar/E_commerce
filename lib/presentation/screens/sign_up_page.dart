import 'dart:ui';

import 'package:firebase_e_commerce/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/auth/auth_bloc.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'SignUp here',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.message.toString(),
                ),
              ),
            );
          }
          if (state is AuthSuccess) {
            Navigator.pushReplacement(context, HomeScreen.rout());
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return Container(
                height: 250,
                alignment: Alignment.center,
                child: const CircularProgressIndicator());
          }
          return SafeArea(
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                ),
                TextField(
                  controller: emailController,
                ),
                TextField(
                  controller: passwordController,
                ),
                ElevatedButton(
                    onPressed: () {
                      context.read<AuthBloc>().add(SignUpEvent(
                            email: emailController.text,
                            password: passwordController.text,
                            name: nameController.text,
                            createdAt: DateTime.now(),
                          ));
                    },
                    child: Text('signup'))
              ],
            ),
          );
        },
      ),
    );
  }
}
