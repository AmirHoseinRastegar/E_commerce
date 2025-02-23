
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
    final userRef = fireStore.collection('users').doc(user.uid);
    print('User UID: ${user.uid}');

    final userDoc = await userRef.get();

    if (!userDoc.exists) {
      throw Exception('User document not found for UID: ${user.uid}');
    }

    await userRef.update(user.toJson());

    final updatedUser = await userRef.get();
    return UserModel.fromJson(updatedUser.data()!,user.uid);
  }
}