import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_e_commerce/core/failure.dart';

import 'package:firebase_e_commerce/data/model/user_model.dart';

import 'package:fpdart/src/either.dart';

import '../../domain/repository/auth_repository.dart';
import '../data_source/auth_firebase_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthFirebaseDatasource authFirebaseDatasource;
  final FirebaseFirestore dataBase;

  AuthRepositoryImpl(
      {required this.authFirebaseDatasource, required this.dataBase});

  @override
  Future<Either<Failure, UserModel>> login(
      String email, String password) async {
    try {
      final user = await authFirebaseDatasource.login(email, password);

      return Right(user);

      // final currentUser = FirebaseAuth.instance.currentUser;
      // if (currentUser == null) {
      //   return Left(Failure('user not found'));
      // }
      // final document =
      //     await dataBase.collection('users').doc(currentUser.uid).get();
      // if (!document.exists) {
      //   return Left(Failure('user not found'));
      // }
      //
      // final userData = document.data();
      // final userModel = UserModel(
      //   createdAT: (userData?['created_at'] as Timestamp),
      //   name: userData?['name'] ?? '',
      //   email: currentUser.email ?? email,
      //   uid: currentUser.uid,
      // );
      // return Right(userModel);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  User? get currentUser => FirebaseAuth.instance.currentUser;

  @override
  Future<Either<Failure, UserModel>> signUp(
      String email, String password, String name, Timestamp createdAt) async {
    try {
      final res =
          await authFirebaseDatasource.signUp(email, password, name, createdAt);
      return Right(res);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
