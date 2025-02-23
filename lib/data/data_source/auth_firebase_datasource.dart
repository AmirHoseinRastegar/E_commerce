import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_e_commerce/data/model/user_model.dart';

abstract class AuthFirebaseDatasource {
  Future<UserModel> signUp(
      String email, String password, String name, Timestamp createdAt);

  Future<UserModel> login(
    String email,
    String password,
  );

  Future<void> logOut();
}

class AuthFireBaseImpl implements AuthFirebaseDatasource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFireStore;

  AuthFireBaseImpl(
      {required this.firebaseAuth, required this.firebaseFireStore});

  @override
  Future<UserModel> signUp(
      String email, String password, String name, Timestamp createdAt) async {
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

  @override
  Future<UserModel> login(String email, String password) async {
    try {
      final res = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = res.user?.uid;

      final user2 = await firebaseFireStore.collection('users').doc(user).get();

      return UserModel(
          createdAT: user2.data()?['created_at'] ?? Timestamp.now(),
          name: user2.data()?['name'] ?? '',
          email: email,
          uid: user!);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> logOut() async {
    try {
      await firebaseAuth.signOut();
    } catch (e) {
      throw Exception('Failed');
    }
  }
}
