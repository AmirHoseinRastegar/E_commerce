import 'package:firebase_e_commerce/data/model/user_model.dart';
import 'package:firebase_e_commerce/presentation/blocs/edit_user_cubit/edit_user_data_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditInfoScreen extends StatelessWidget {

  static const screenRout = '/edit_info_screen';

  const EditInfoScreen({super.key, });

  @override
  Widget build(BuildContext context) {
    final userModel= ModalRoute.of(context)!.settings.arguments as UserModel ;
    final nameController = TextEditingController(text: userModel.name);
    final emailController = TextEditingController(text: userModel.email);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit your profile'),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(labelText: 'Name'),
          ),
          TextField(
            controller: emailController,
            decoration: const InputDecoration(labelText: 'Email'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              final updatedUser = UserModel(
                uid: userModel.uid,
                name: nameController.text,
                email: emailController.text,
                createdAT: userModel.createdAT,
              );
              context.read<EditUserDataCubit>().onEditUseData(updatedUser);
            },
            child: const Text('Save Changes'),
          )
        ],
      ),
    );
  }
}
