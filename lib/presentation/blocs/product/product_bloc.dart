import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_e_commerce/data/model/carousel_model.dart';
import 'package:firebase_e_commerce/data/model/product_model.dart';
import 'package:firebase_e_commerce/domain/usecases/carousel_usecase.dart';
import 'package:meta/meta.dart';

import '../../../domain/usecases/fetch_products_usecase.dart';

part 'product_event.dart';

part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final FetchProductUseCase fetchProductUseCase;
  final CarouselUseCase carouselUseCase;

  ProductBloc(
      {required this.fetchProductUseCase, required this.carouselUseCase})
      : super(ProductInitial()) {
    on<FetchProductEvent>(onFetchProduct);
  }



  void onFetchProduct(
      FetchProductEvent event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    try {
      final res = await fetchProductUseCase.call(NoParams());
      res.fold(
        (l) => emit(
          ProductFailed(message: l.message),
        ),
        (r) => emit(
          ProductSuccess(productModel: r),
        ),
      );
    } catch (e) {
      emit(ProductFailed(message: e.toString()));
    }
  }
}
