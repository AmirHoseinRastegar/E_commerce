import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_e_commerce/data/model/user_model.dart';
import 'package:meta/meta.dart';

import '../../../domain/repository/edit_user_repository.dart';

part 'edit_user_data_state.dart';

class EditUserDataCubit extends Cubit<EditUserDataState> {
  final EditUserRepository editUserRepository;

  EditUserDataCubit(this.editUserRepository) : super(EditUserDataInitial());

  Future<void> onEditUseData(UserModel user) async {
    emit(EditUserDataLoading());
    try {
      final res = await editUserRepository.editUserData(user);
      res.fold((l) => emit(EditUserDataError(message: l.message)),
          (r) => emit(EditUserDataSuccess(userModel: r)));
    } catch (e) {
      emit(EditUserDataError(message: e.toString()));
    }
  }
}
