import 'package:firebase_e_commerce/core/failure.dart';

import 'package:firebase_e_commerce/data/model/user_model.dart';

import 'package:fpdart/src/either.dart';

import '../../domain/repository/edit_user_repository.dart';
import '../data_source/user_datasource.dart';

class EditUserRepositoryImpl implements EditUserRepository {
  final UserDataSource userDataSource;

  EditUserRepositoryImpl(this.userDataSource);

  @override
  Future<Either<Failure, UserModel>> editUserData(UserModel user) async {
    try {
      final result = await userDataSource.editUserData(user);
      return Right(result);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
