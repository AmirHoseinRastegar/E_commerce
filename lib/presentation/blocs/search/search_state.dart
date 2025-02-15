part of 'search_bloc.dart';

@immutable
sealed class SearchState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class SearchInitial extends SearchState {}

final class SearchLoading extends SearchState {}

final class SearchSuccess extends SearchState {
  final List<ProductModel> products;

  SearchSuccess({required this.products});

  @override
  List<Object?> get props => [products];
}

final class SearchError extends SearchState {
  final String message;

  SearchError({required this.message});

  @override
  List<Object?> get props => [message];
}
