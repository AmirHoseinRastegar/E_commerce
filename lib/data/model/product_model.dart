import 'carousel_model.dart';

class ProductModel {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final num price;
  final num discount;
  final bool isDiscounted;
  final String category;

  ProductModel( {
     this.discount=0.0,
     this.isDiscounted=false,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.category,
    required this.id,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json, String id) {

    return ProductModel(
      id: id,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      price: json['price'] ?? 0.0,
      discount: json['discount'] ?? 0.0,
      isDiscounted: json['isDiscounted'] ?? false,
      category: json['category'] ?? '',
    );
  }

  ProductModel copyWith({
    String? id,
    String? name,
    String? description,
    String? imageUrl,
    num? price,
    num? discount,
    bool? isDiscounted,
    String? category,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      price: price ?? this.price,
      discount: discount ?? this.discount,
      isDiscounted: isDiscounted ?? this.isDiscounted,
      category: category ?? this.category,
    );
  }
}
