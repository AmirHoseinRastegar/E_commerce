import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_e_commerce/core/loading.dart';
import 'package:firebase_e_commerce/main_wrapper.dart';
import 'package:firebase_e_commerce/presentation/screens/home/home_screen.dart';
import 'package:firebase_e_commerce/presentation/widgets/text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../blocs/auth/auth_bloc.dart';
import '../../widgets/elevated_button_widget.dart';

class SignUpPage extends StatefulWidget {
  static const screenRout = 'signup_screen';

  final void Function() onTap;

  const SignUpPage({super.key, required this.onTap});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final _formKey2 = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

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
            Navigator.pushNamedAndRemoveUntil(
                context, MainWrapper.screenRout, (route) => false);
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const LoadingPage();
          }
          return SafeArea(
            child: Center(
              child: ListView(
                padding: const EdgeInsets.all(15),
                shrinkWrap: true, // Makes ListView only as big as needed
                children: [
                  Form(
                    key: _formKey2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomTextFormField(
                          hintText: 'name',
                          controller: nameController,
                          obscure: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'please enter your name';
                            }
                          },
                        ),
                        const SizedBox(height: 8),
                        CustomTextFormField(
                          hintText: 'email',
                          controller: emailController,
                          obscure: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'please enter your email';
                            }
                          },
                        ),
                        const SizedBox(height: 8),
                        CustomTextFormField(
                          hintText: 'password',
                          controller: passwordController,
                          obscure: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'please enter password';
                            }
                            if (value.length < 6) {
                              return 'password must be at least 6 characters';
                            }
                          },
                        ),
                        const SizedBox(height: 8),
                        CustomTextFormField(
                          hintText: 'confirm password',
                          controller: confirmPasswordController,
                          obscure: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "please confirm your password";
                            }
                            if (value != passwordController.text) {
                              return 'passwords do not match';
                            }
                          },
                        ),
                        const SizedBox(height: 15),
                        CustomElevatedButton(
                          onTap: () {
                            if (_formKey2.currentState?.validate() ?? false) {
                              context.read<AuthBloc>().add(SignUpEvent(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  name: nameController.text,
                                  createdAt: Timestamp.now()));
                            }
                          },
                          child: Text('Sign Up',
                              style: GoogleFonts.robotoMono(
                                textStyle: TextStyle(
                                    fontSize: 25, color: Colors.grey.shade100),
                              )),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already have an account?',
                              style: GoogleFonts.robotoMono(
                                textStyle: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w500),
                              ),
                            ),
                            TextButton(
                              onPressed: widget.onTap,
                              child: const Text(
                                'Login',
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w700),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
