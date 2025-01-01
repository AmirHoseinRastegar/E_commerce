import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_e_commerce/domain/repository/auth_repository.dart';
import 'package:firebase_e_commerce/domain/usecases/login_usecase.dart';
import 'package:firebase_e_commerce/presentation/blocs/auth/auth_bloc.dart';
import 'package:get_it/get_it.dart';

import '../data/data_source/auth_firebase_datasource.dart';
import '../data/repository/auth_repositoryimpl.dart';
import '../domain/usecases/signup_usecase.dart';

final sl = GetIt.instance;

void setUpDependencies() {
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
  sl.registerLazySingleton<AuthFirebaseDatasource>(
      () => AuthFireBaseImpl(firebaseAuth: sl(), firebaseFireStore: sl()));
  sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(authFirebaseDatasource: sl(), dataBase: sl()));
  sl.registerLazySingleton(() => SignUpUseCase(authRepository: sl()));
  sl.registerLazySingleton(() => LoginUseCase(authRepository: sl()));
  sl.registerFactory(() =>
      AuthBloc(signUpUseCase: sl(), authRepository: sl(), loginUseCase: sl()));
}
