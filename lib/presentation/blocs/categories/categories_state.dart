part of 'categories_bloc.dart';

@immutable
sealed class CategoriesState extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class CategoriesInitial extends CategoriesState {}
final class CategoriesLoading extends CategoriesState {

}
final class CategoriesSuccess extends CategoriesState {
  final List<ProductModel> loadedRelatedProducts ;
  CategoriesSuccess({required this.loadedRelatedProducts});
  @override
  // TODO: implement props
  List<Object?> get props => [loadedRelatedProducts];
}
final class CategoriesError extends CategoriesState {
  final String message;
  CategoriesError({required this.message});
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
