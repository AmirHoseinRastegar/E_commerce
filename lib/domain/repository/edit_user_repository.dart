import 'package:firebase_e_commerce/core/failure.dart';
import 'package:firebase_e_commerce/data/model/user_model.dart';
import 'package:fpdart/fpdart.dart';

abstract class EditUserRepository {

  Future<Either<Failure,UserModel>> editUserData(UserModel user);
}

