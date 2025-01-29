class CartModel {
  final String productId;
  final String name;
  final double price;
  final String imageUrl;
  final int quantity;

  CartModel({
    required this.productId,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.quantity,
  });

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'name': name,
      'price': price,
      'imageUrl': imageUrl,
      'quantity': quantity,
    };
  }

  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
      productId: map['productId'],
      name: map['name'],
      price: map['price'].toDouble(),
      imageUrl: map['imageUrl'],
      quantity: map['quantity'],
    );
  }
}
