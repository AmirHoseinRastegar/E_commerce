import 'package:firebase_e_commerce/core/usecase_interface.dart';
import 'package:firebase_e_commerce/data/model/user_model.dart';
import 'package:firebase_e_commerce/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

import '../../core/failure.dart';

class LoginUseCase implements UseCase<UserModel,LoginParams>{
  final AuthRepository authRepository;

  LoginUseCase({required this.authRepository});

  @override
  Future<Either<Failure, UserModel>> call(LoginParams params) async {
    final res = await authRepository.login(params.email, params.password);
    return res;
  }

}


class LoginParams{
  final String email;
  final String password;

  LoginParams({required this.email, required this.password});
}