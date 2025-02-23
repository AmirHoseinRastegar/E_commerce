import 'package:firebase_e_commerce/data/model/user_model.dart';
import 'package:firebase_e_commerce/domain/repository/edit_user_repository.dart';
import 'package:firebase_e_commerce/presentation/blocs/edit_user_cubit/edit_user_data_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditInfoScreen extends StatelessWidget {
  final UserModel userModel;

  static route(UserModel userModel) =>
      MaterialPageRoute(
        builder: (context) =>
            EditInfoScreen(
              userModel: userModel,
            ),
      );
  static const screenRout = '/edit_info_screen';

  const EditInfoScreen({
    super.key,
    required this.userModel,
  });

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController(text: userModel.name);
    final emailController = TextEditingController(text: userModel.email);
    return BlocConsumer<EditUserDataCubit, EditUserDataState>(
      listener: (context, state) {
       if(state is EditUserDataSuccess){
         Navigator.of(context).pop();
       }
       if(state is EditUserDataError){
         ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(
             content: Text(state.message),

           ),
         );
       }
      },
      builder: (context, state) {

        if(state is EditUserDataLoading){
          return const Center(child: CircularProgressIndicator(),);
        }
        return Scaffold(
          appBar: AppBar(
            title: const Text('Edit your profile'),
          ),
          body: ListView(
            padding: EdgeInsets.all(15),
            shrinkWrap: true,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              const SizedBox(
                height: 20,
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
      },
    );
  }
}
