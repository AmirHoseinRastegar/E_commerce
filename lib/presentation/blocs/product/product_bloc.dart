import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_e_commerce/data/model/carousel_model.dart';
import 'package:firebase_e_commerce/data/model/product_model.dart';
import 'package:firebase_e_commerce/domain/usecases/carousel_usecase.dart';
import 'package:fpdart/fpdart.dart';
import 'package:meta/meta.dart';

import '../../../core/failure.dart';
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
      final results = await Future.wait([
        fetchProductUseCase.call(NoParams()),
        carouselUseCase.call(NoParams()),
      ]);

      final productResult = results[0] as Either<Failure, List<ProductModel>>;
      final carouselResult = results[1] as Either<Failure, List<CarouselModel>>;

      productResult.fold(
            (l) => emit(ProductFailed(message: l.message)),
            (r) {
          carouselResult.fold(
                (l) => emit(ProductFailed(message: l.message)),
                (carousels) => emit(
              ProductSuccess(
                productModel: r,
                carouselModel: carousels,
              ),
            ),
          );
        },
      );
    }  catch (e) {
      emit(ProductFailed(message: e.toString()));
    }
  }
}
