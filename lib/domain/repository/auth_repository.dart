import 'package:firebase_e_commerce/data/model/user_model.dart';
import 'package:fpdart/fpdart.dart';

import '../../core/failure.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserModel>> signUp(
      String email, String password, String name,DateTime createdAt);

  Future<Either<Failure, UserModel>> login(
      String email, String password,);
}
