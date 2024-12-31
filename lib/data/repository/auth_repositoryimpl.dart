import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_e_commerce/core/failure.dart';

import 'package:firebase_e_commerce/data/model/user_model.dart';

import 'package:fpdart/src/either.dart';

import '../../domain/repository/auth_repository.dart';
import '../data_source/auth_firebase_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthFirebaseDatasource authFirebaseDatasource;

  AuthRepositoryImpl({required this.authFirebaseDatasource});

  @override
  Future<Either<Failure, UserModel>> login(String email, String password) {
    // TODO: implement login
    throw UnimplementedError();
  }
   User? get currentUser => FirebaseAuth.instance.currentUser;
  @override
  Future<Either<Failure, UserModel>> signUp(
      String email, String password, String name,DateTime createdAt) async {
    try {
      final res = await authFirebaseDatasource.signUp(email, password, name,createdAt);
      return Right(res);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
