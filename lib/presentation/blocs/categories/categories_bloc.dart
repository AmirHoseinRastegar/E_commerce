import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../data/model/product_model.dart';
import '../../../domain/usecases/category_usecase.dart';

part 'categories_event.dart';

part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final CategoryUseCase categoryUseCase;

  CategoriesBloc({
    required this.categoryUseCase,
  }) : super(CategoriesInitial()) {
    on<GetProductCategory>(_onGetProductCategory);
    on<ResetCategoriesEvent>((event, emit) {
      emit(CategoriesInitial()); // Clear the state
    });
  }

  void _onGetProductCategory(
      GetProductCategory event, Emitter<CategoriesState> emit) async {
    emit(CategoriesLoading());
    Future.delayed(const Duration(milliseconds: 900));
    try {
      final res =
          await categoryUseCase.call(CategoryStringParams(event.category));
      res.fold((l) => emit(CategoriesError(message: l.message)),
          (r) => emit(CategoriesSuccess(loadedRelatedProducts: r)));
    } catch (e) {
      emit(CategoriesError(message: e.toString()));
    }
  }
}
