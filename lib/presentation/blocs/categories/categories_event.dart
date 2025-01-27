part of 'categories_bloc.dart';

@immutable
sealed class CategoriesEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class GetProductCategory extends CategoriesEvent {
  final String category;

  GetProductCategory({required this.category});

  @override
  // TODO: implement props
  List<Object?> get props => [category];
}
class ResetCategoriesEvent extends CategoriesEvent{}