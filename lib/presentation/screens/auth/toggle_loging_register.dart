import 'package:firebase_e_commerce/presentation/screens/auth/login_page.dart';
import 'package:firebase_e_commerce/presentation/screens/auth/sign_up_page.dart';
import 'package:flutter/material.dart';

class ToggleLoginRegister extends StatefulWidget {
  static const screenRout= 'toggle_login_register_screen';

  const ToggleLoginRegister({super.key});

  @override
  State<ToggleLoginRegister> createState() => _ToggleLoginRegisterState();
}

class _ToggleLoginRegisterState extends State<ToggleLoginRegister> {
  bool isLogin = true;
void toggle(){
  setState(() {
     isLogin=!isLogin;
  });
}
  @override
  Widget build(BuildContext context) {
    if (isLogin) {
      return  LoginPage(onTap: toggle,);
    } else {
      return  SignUpPage(onTap: toggle,);
    }
  }
}
