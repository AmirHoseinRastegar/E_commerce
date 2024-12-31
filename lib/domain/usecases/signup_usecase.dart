import 'package:firebase_e_commerce/core/failure.dart';
import 'package:firebase_e_commerce/domain/repository/auth_repository.dart';

import 'package:fpdart/src/either.dart';

import '../../core/usecase_interface.dart';
import '../../data/model/user_model.dart';

class SignUpUseCase implements UseCase<UserModel, SignUpParams> {
  final AuthRepository authRepository;

  SignUpUseCase({required this.authRepository});

  @override
  Future<Either<Failure, UserModel>> call(SignUpParams params) async {
    final res = await authRepository.signUp(
        params.email, params.password, params.name, params.createdAt);
    return res;
  }
}

class SignUpParams {
  final String name;
  final String email;
  final String password;
  final DateTime createdAt;

  SignUpParams(
      {required this.name,
      required this.email,
      required this.password,
      required this.createdAt});
}
