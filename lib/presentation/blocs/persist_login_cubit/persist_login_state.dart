part of 'persist_login_cubit.dart';

@immutable
sealed class PersistLoginState {}

final class PersistLoginInitial extends PersistLoginState {}

final class Authenticated extends PersistLoginState {}

final class UnAuthenticated extends PersistLoginState {}
