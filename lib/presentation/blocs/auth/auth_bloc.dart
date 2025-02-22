import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_e_commerce/data/model/user_model.dart';
import 'package:firebase_e_commerce/domain/repository/auth_repository.dart';
import 'package:firebase_e_commerce/domain/usecases/login_usecase.dart';
import 'package:meta/meta.dart';

import '../../../domain/usecases/signup_usecase.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignUpUseCase signUpUseCase;
  final AuthRepository authRepository;
  final LoginUseCase loginUseCase;

  AuthBloc({
    required this.loginUseCase,
    required this.signUpUseCase,
    required this.authRepository,
  }) : super(AuthInitial()) {
    on<SignUpEvent>(onSignUp);
    on<LoginEvent>(onLogin);
    on<LogOutEvent>(onLogOut);
  }

  Future<void> onLogOut(LogOutEvent event, Emitter<AuthState> emit) async {
    try {
      emit(AuthLoading());
      final res = await authRepository.logOut();
      res.fold((l) => emit(AuthError(message: l.message)), (r) {
        emit(AuthLogOutSuccess());
      });
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> onSignUp(SignUpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final result = await signUpUseCase.call(SignUpParams(
          name: event.name,
          email: event.email,
          password: event.password,
          createdAt: event.createdAt));
      result.fold(
        (l) => emit(AuthError(message: l.toString())),
        (r) => emit(
          AuthSuccess(user: r),
        ),
      );
    } on FirebaseAuthException catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final res = await loginUseCase.call(LoginParams(
        email: event.email,
        password: event.password,
      ));
      res.fold(
        (l) => emit(
          AuthError(message: l.message),
        ),
        (r) => emit(
          AuthSuccess(user: r),
        ),
      );
    } on FirebaseAuthException catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }
}
