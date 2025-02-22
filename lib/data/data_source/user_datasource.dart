
import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/user_model.dart';

abstract class UserDataSource {
  Future<UserModel> editUserData(UserModel user);
}

class UserDataSourceImpl implements UserDataSource{
  final FirebaseFirestore fireStore;

  UserDataSourceImpl({required this.fireStore});


  @override
  Future<UserModel> editUserData(UserModel user)async{
   await fireStore.collection('users').doc(user.uid).update(user.toJson());
   final updatedUser= await fireStore.collection('users').doc(user.uid).get();
   return UserModel.fromJson(updatedUser.data()!);
  }
}