import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../data/model/product_model.dart';
import '../../../domain/usecases/search_usecase.dart';

part 'search_event.dart';

part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchUseCase searchUseCase;

  SearchBloc({required this.searchUseCase}) : super(SearchInitial()) {
    on<SearchProductsEvent>((event, emit) async {
      final result = await searchUseCase.call(event.query);
      result.fold((failure) {
        emit(SearchError(message: failure.toString()));
      }, (products) {
        emit(SearchSuccess(products: products));
      });
    });
  }
}
