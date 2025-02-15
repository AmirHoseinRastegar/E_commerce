part of 'search_bloc.dart';

@immutable
sealed class SearchEvent {}

class SearchProductsEvent extends SearchEvent {
  final String query;
  SearchProductsEvent({required this.query});
}
