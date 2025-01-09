import 'package:firebase_e_commerce/core/loading.dart';
import 'package:firebase_e_commerce/presentation/blocs/auth/auth_bloc.dart';
import 'package:firebase_e_commerce/presentation/widgets/elevated_button_widget.dart';
import 'package:firebase_e_commerce/presentation/widgets/text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../home/home_screen.dart';

class LoginPage extends StatefulWidget {
  static const screenRout = 'Login_screen';

  final void Function() onTap;

  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Login here',
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
            return const LoadingPage();
          }
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextFormField(
                      hintText: 'email',
                      controller: emailController,
                      obscure: false, validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "please enter your email";
                      }
                    },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextFormField(
                        hintText: 'Password',
                        controller: passwordController,
                        obscure: true, validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "please enter your password";
                      }
                    }
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomElevatedButton(
                      onTap: () {
                      if(_formKey.currentState!.validate()){
                        context.read<AuthBloc>().add(LoginEvent(
                            email: emailController.text,
                            password: passwordController.text));
                      }
                      },
                      child: Text(
                        'Login',
                        style:
                        TextStyle(fontSize: 25, color: Colors.grey.shade100),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Don\'t have an account?',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        ),
                        TextButton(
                          onPressed: widget.onTap,
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w700),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
