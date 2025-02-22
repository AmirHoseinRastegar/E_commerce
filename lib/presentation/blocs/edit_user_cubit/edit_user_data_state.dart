part of 'edit_user_data_cubit.dart';

@immutable
sealed class EditUserDataState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class EditUserDataInitial extends EditUserDataState {}

final class EditUserDataLoading extends EditUserDataState {}

final class EditUserDataError extends EditUserDataState {
  final String message;

  EditUserDataError({required this.message});

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

final class EditUserDataSuccess extends EditUserDataState {
  final UserModel userModel;

  EditUserDataSuccess({required this.userModel});

  @override
  // TODO: implement props
  List<Object?> get props => [userModel];
}
