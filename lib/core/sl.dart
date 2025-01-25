import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_e_commerce/data/data_source/carousel_datasource.dart';
import 'package:firebase_e_commerce/data/data_source/product_datasource.dart';
import 'package:firebase_e_commerce/data/repository/carousel_repositoryimpl.dart';
import 'package:firebase_e_commerce/data/repository/product_repositoryimpl.dart';
import 'package:firebase_e_commerce/domain/repository/auth_repository.dart';
import 'package:firebase_e_commerce/domain/repository/carousel_repository.dart';
import 'package:firebase_e_commerce/domain/repository/product_repository.dart';
import 'package:firebase_e_commerce/domain/usecases/carousel_usecase.dart';
import 'package:firebase_e_commerce/domain/usecases/fetch_discounted_products.dart';
import 'package:firebase_e_commerce/domain/usecases/fetch_products_usecase.dart';
import 'package:firebase_e_commerce/domain/usecases/login_usecase.dart';
import 'package:firebase_e_commerce/presentation/blocs/auth/auth_bloc.dart';
import 'package:firebase_e_commerce/presentation/blocs/product/product_bloc.dart';
import 'package:firebase_e_commerce/presentation/blocs/product_details/product_details_bloc.dart';
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
  sl.registerLazySingleton<CarouselRepository>(
      () => CarouselRepositoryImpl(carouselDataSource: sl()));
  sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(authFirebaseDatasource: sl(), dataBase: sl()));
  sl.registerLazySingleton<ProductRepository>(
      () => ProductRepositoryImpl(productDataSource: sl()));
  sl.registerLazySingleton<ProductDataSource>(
      () => ProductDataSourceImpl(db: sl()));
  sl.registerLazySingleton<CarouselDataSource>(
      () => CarouselDataSourceImpl(db: sl()));
  sl.registerLazySingleton(() => SignUpUseCase(authRepository: sl()));
  sl.registerLazySingleton(() => LoginUseCase(authRepository: sl()));
  sl.registerLazySingleton(() => CarouselUseCase(carouselRepository: sl()));
  sl.registerLazySingleton(
      () => FetchDiscountedUseCase(productRepository: sl()));
  sl.registerLazySingleton(() => FetchProductUseCase(productRepository: sl()));
  sl.registerFactory(() =>
      AuthBloc(signUpUseCase: sl(), authRepository: sl(), loginUseCase: sl()));
  sl.registerFactory(() => ProductDetailsBloc(productRepository: sl()));
  sl.registerFactory(() => ProductBloc(
      fetchProductUseCase: sl(),
      carouselUseCase: sl(),
      fetchDiscountedUseCase: sl()));
}
