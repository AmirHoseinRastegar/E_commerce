import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final bool obscure;
  final TextEditingController controller;
  final Function validator;

  const CustomTextFormField({
    super.key,
    required this.hintText,
    required this.controller,
    required this.obscure,
    required this.validator
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator:(value) {

        return validator(value);
      },
      obscureText: obscure,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey.shade700),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                width: 2, color: Theme.of(context).colorScheme.inversePrimary),
            borderRadius: BorderRadius.circular(15),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide:
                BorderSide(color: Theme.of(context).colorScheme.primary),
          )),
    );
  }
}
