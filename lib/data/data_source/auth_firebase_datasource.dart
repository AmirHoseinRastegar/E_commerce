import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_e_commerce/data/model/user_model.dart';

abstract class AuthFirebaseDatasource {
  Future<UserModel> signUp(String email, String password, String name,DateTime createdAt);
}

class AuthFireBaseImpl implements AuthFirebaseDatasource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFireStore;

  AuthFireBaseImpl(
      {required this.firebaseAuth, required this.firebaseFireStore});

  @override
  Future<UserModel> signUp(
      String email, String password, String name, DateTime createdAt) async {
    try {
      final credentials = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = credentials.user?.uid;
      await firebaseFireStore
          .collection('users')
          .doc(user)
          .set({'name': name, 'email': email, 'created_at': createdAt});

      return UserModel(
        createdAT: createdAt,
        name: name,
        email: email,
        uid: user!,
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
