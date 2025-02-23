import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_e_commerce/data/data_source/carousel_datasource.dart';
import 'package:firebase_e_commerce/data/data_source/product_datasource.dart';
import 'package:firebase_e_commerce/data/data_source/search_datasource.dart';
import 'package:firebase_e_commerce/data/repository/carousel_repositoryimpl.dart';
import 'package:firebase_e_commerce/data/repository/cart_repositoryimpl.dart';
import 'package:firebase_e_commerce/data/repository/product_repositoryimpl.dart';
import 'package:firebase_e_commerce/data/repository/search_repositoryimpl.dart';
import 'package:firebase_e_commerce/domain/repository/auth_repository.dart';
import 'package:firebase_e_commerce/domain/repository/carousel_repository.dart';
import 'package:firebase_e_commerce/domain/repository/cart_repository.dart';
import 'package:firebase_e_commerce/domain/repository/product_repository.dart';
import 'package:firebase_e_commerce/domain/repository/search_repository.dart';
import 'package:firebase_e_commerce/domain/usecases/carousel_usecase.dart';
import 'package:firebase_e_commerce/domain/usecases/category_usecase.dart';
import 'package:firebase_e_commerce/domain/usecases/fetch_discounted_products.dart';
import 'package:firebase_e_commerce/domain/usecases/fetch_products_usecase.dart';
import 'package:firebase_e_commerce/domain/usecases/login_usecase.dart';
import 'package:firebase_e_commerce/presentation/blocs/auth/auth_bloc.dart';
import 'package:firebase_e_commerce/presentation/blocs/cart/cart_bloc.dart';
import 'package:firebase_e_commerce/presentation/blocs/categories/categories_bloc.dart';
import 'package:firebase_e_commerce/presentation/blocs/edit_user_cubit/edit_user_data_cubit.dart';
import 'package:firebase_e_commerce/presentation/blocs/product/product_bloc.dart';
import 'package:firebase_e_commerce/presentation/blocs/product_details/product_details_bloc.dart';
import 'package:get_it/get_it.dart';

import '../data/data_source/auth_firebase_datasource.dart';
import '../data/data_source/user_datasource.dart';
import '../data/model/user_model.dart';
import '../data/repository/auth_repositoryimpl.dart';
import '../data/repository/edit_user_repositoryimpl.dart';
import '../domain/repository/edit_user_repository.dart';
import '../domain/usecases/search_usecase.dart';
import '../domain/usecases/signup_usecase.dart';
import '../presentation/blocs/search/search_bloc.dart';

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
      () => ProductDataSourceImpl(db: sl()));  sl.registerLazySingleton<UserDataSource>(
      () => UserDataSourceImpl(fireStore: sl()));
  sl.registerLazySingleton<SearchDataSource>(
      () => SearchDataSourceImpl(firebaseFireStore: sl()));
  sl.registerLazySingleton<CartRepository>(
      () => CartRepositoryImpl(firebaseFirestore: sl()));
  sl.registerLazySingleton<SearchRepository>(
      () => SearchRepositoryImpl(searchDataSource: sl()));
  sl.registerLazySingleton<EditUserRepository>(
      () => EditUserRepositoryImpl( sl<UserDataSource>()));
  sl.registerLazySingleton<CarouselDataSource>(
      () => CarouselDataSourceImpl(db: sl()));
  sl.registerLazySingleton(() => SignUpUseCase(authRepository: sl()));
  sl.registerLazySingleton(() => SearchUseCase(searchRepository: sl()));
  sl.registerLazySingleton(() => CategoryUseCase(productRepository: sl()));
  sl.registerLazySingleton(() => LoginUseCase(authRepository: sl()));
  sl.registerLazySingleton(() => CarouselUseCase(carouselRepository: sl()));
  sl.registerLazySingleton(
      () => FetchDiscountedUseCase(productRepository: sl()));
  sl.registerLazySingleton(() => FetchProductUseCase(productRepository: sl()));
  sl.registerFactory(() =>
      AuthBloc(signUpUseCase: sl(), authRepository: sl(), loginUseCase: sl()));
  sl.registerFactory(() => CartBloc(cartRepository: sl()));
  sl.registerFactory(() => EditUserDataCubit( sl<EditUserRepository>()));
  sl.registerFactory(() => SearchBloc(searchUseCase: sl()));
  sl.registerFactory(() => CategoriesBloc(categoryUseCase: sl()));
  sl.registerFactory(() => ProductDetailsBloc(productRepository: sl()));
  sl.registerFactory(() => ProductBloc(
      fetchProductUseCase: sl(),
      carouselUseCase: sl(),
      fetchDiscountedUseCase: sl()));
}
