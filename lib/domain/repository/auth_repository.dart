import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_e_commerce/data/model/user_model.dart';
import 'package:fpdart/fpdart.dart';

import '../../core/failure.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserModel>> signUp(
      String email, String password, String name,Timestamp createdAt);

  Future<Either<Failure, UserModel>> login(
      String email, String password,);

  Future<Either<Failure, void>> logOut(

  );

  User? get currentUser;
}
