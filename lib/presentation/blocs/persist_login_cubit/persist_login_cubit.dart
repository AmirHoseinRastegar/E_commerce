import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/repository/auth_repository.dart';

part 'persist_login_state.dart';

class PersistLoginCubit extends Cubit<PersistLoginState> {
  final AuthRepository authRepository;

  PersistLoginCubit({required this.authRepository})
      : super(PersistLoginInitial());

  Future<void> persistLogin() async {
    if (authRepository.currentUser != null) {
      emit(Authenticated());
    } else {
      emit(UnAuthenticated());
    }
  }
}
