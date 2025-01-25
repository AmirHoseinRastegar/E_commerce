part of 'product_details_bloc.dart';

@immutable
sealed class ProductDetailsEvent extends Equatable{

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

 class FetchProductDetails extends ProductDetailsEvent {
  final String id;
  FetchProductDetails({required this.id});

  @override
  // TODO: implement props
  List<Object?> get props => [id];

 }
