import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_e_commerce/presentation/screens/auth/toggle_loging_register.dart';
import 'package:firebase_e_commerce/presentation/screens/cart/cart_screen_navigator.dart';
import 'package:firebase_e_commerce/presentation/screens/profile/edit_info_screen.dart';
import 'package:firebase_e_commerce/presentation/screens/profile/profile_screen_navigator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/user_model.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/user/user_cubit.dart';
import '../home/home_screen_navigator.dart';

class ProfileScreen extends StatefulWidget {
  static const screenRout = '/';
  final FirebaseFirestore fireStore;

  const ProfileScreen({super.key, required this.fireStore});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? _name;
  String? _email;

  @override
  void initState() {
    super.initState();

    _fetchUserData();
  }

  // Future<UserModel> getUserInfo() async {
  //   final User? user = FirebaseAuth.instance.currentUser;
  //
  //   try {
  //     final userDoc =
  //         await widget.fireStore.collection('users').doc(user?.uid).get();
  //     if (!userDoc.exists) {
  //       throw Exception('User document does not exist');
  //     }
  //     final userModel = UserModel.fromJson(userDoc.data()!);
  //
  //     return userModel;
  //   } catch (e) {
  //     throw Exception('Failed:$e');
  //   }
  // }

  Future<void> _fetchUserData() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print('No user is signed in');
      return;
    }

    try {
      widget.fireStore
          .collection('users')
          .doc(user.uid)
          .snapshots()  // Listen to real-time changes
          .listen((userDoc) {
        if (userDoc.exists) {
          setState(() {
            _name = userDoc['name'];
            _email = userDoc['email'];
          });
        } else {
          print('User document does not exist');
        }
      });
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserCubit(widget.fireStore),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Profile',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
          ),
        ),
        body: BlocConsumer<UserCubit, UserState>(
          listener: (context, state) {
            if (state is UserSuccess) {
              Navigator.of(context,rootNavigator: true)
                  .push(EditInfoScreen.route(state.userModel));
            }
            if (state is UserError) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          builder: (context, state) {
            if(state is UserLoading){
              return const Center(child: CircularProgressIndicator(),);
            }
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Name: $_name ',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black.withOpacity(0.58),
                            ),
                          ),
                          const SizedBox(height: 7),
                          Text(
                            'Email: $_email',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black.withOpacity(0.58),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(
                          Icons.person,
                          color: Colors.black.withOpacity(0.58),
                        ),
                        TextButton(
                          onPressed: ()  {
                          context.read<UserCubit>().getUser();
                          },
                          child: Text(
                            'Edit Info',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              color: Colors.black.withOpacity(0.7),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.logout,
                          color: Colors.black.withOpacity(0.58),
                        ),
                        BlocListener<AuthBloc, AuthState>(
                          listener: (context, state) {
                            if (state is AuthLogOutSuccess) {
                              homeKey.currentState
                                  ?.popUntil((route) => route.isFirst);
                              profileKey.currentState
                                  ?.popUntil((route) => route.isFirst);
                              cartKey.currentState
                                  ?.popUntil((route) => route.isFirst);
                              Navigator.of(context, rootNavigator: true)
                                  .pushNamedAndRemoveUntil(
                                ToggleLoginRegister.screenRout,
                                (route) => false,
                              );
                            }
                          },
                          child: BlocBuilder<AuthBloc, AuthState>(
                            builder: (context, state) {
                              if (state is AuthLoading) {
                                return const CupertinoActivityIndicator();
                              }
                              return TextButton(
                                onPressed: () {
                                  context.read<AuthBloc>().add(LogOutEvent());
                                },
                                child: Text(
                                  'Sign Out',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                    color: Theme.of(context).colorScheme.error,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
