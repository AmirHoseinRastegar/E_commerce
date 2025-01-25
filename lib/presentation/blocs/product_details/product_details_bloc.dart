import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../data/model/product_model.dart';
import '../../../domain/repository/product_repository.dart';

part 'product_details_event.dart';

part 'product_details_state.dart';

class ProductDetailsBloc
    extends Bloc<ProductDetailsEvent, ProductDetailsState> {
  final ProductRepository productRepository;

  ProductDetailsBloc({required this.productRepository})
      : super(ProductDetailsInitial()) {
    on<FetchProductDetails>(_onFetchProductDetails);
  }

  void _onFetchProductDetails(
      FetchProductDetails event, Emitter<ProductDetailsState> emit) async {
    emit(ProductDetailsLoading());
    try {
      final product = await productRepository.getProductDetails(event.id);
      product.fold((l) => emit(ProductDetailsError(message: l.message)),
          (r) => emit(ProductDetailsSuccess(product: r)));
    } catch (e) {
      emit(ProductDetailsError(message: e.toString()));
    }
  }
}
