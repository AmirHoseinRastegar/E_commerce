import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/usecases/fetch_products_usecase.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final FetchProductUseCase fetchProductUseCase;

  ProductBloc({required this.fetchProductUseCase}) : super(ProductInitial()) {
    on<ProductEvent>((event, emit) {
    });
  }
}
