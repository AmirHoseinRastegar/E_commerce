import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_e_commerce/data/model/user_model.dart';
import 'package:firebase_e_commerce/domain/repository/auth_repository.dart';
import 'package:meta/meta.dart';

import '../../../domain/usecases/signup_usecase.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignUpUseCase signUpUseCase;
  final AuthRepository authRepository;

  AuthBloc({
    required this.signUpUseCase,
    required this.authRepository,
  }) : super(AuthInitial()) {
    on<SignUpEvent>(onSignUp);
  }

  Future<void> onSignUp(SignUpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final result = await signUpUseCase.call(SignUpParams(
          name: event.name, email: event.email, password: event.password, createdAt: event.createdAt));
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
}
