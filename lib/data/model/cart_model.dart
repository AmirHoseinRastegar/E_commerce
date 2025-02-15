class CartModel {
  final String productId;
  final String name;
  final double price;
  final double discount; // Make it non-nullable
  final String imageUrl;
  final int quantity;

  CartModel({
    required this.productId,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.quantity,
    this.discount = 0.0, // Default to 0.0
  });

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'name': name,
      'price': price,
      'imageUrl': imageUrl,
      'quantity': quantity,
      'discount': discount, // Always save discount field
    };
  }

  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
      productId: map['productId'],
      name: map['name'],
      price: (map['price'] ?? 0.0).toDouble(),
      imageUrl: map['imageUrl'],
      quantity: map['quantity'] ?? 1,
      discount: (map['discount'] != null) ? (map['discount'] as num).toDouble() : 0.0, // Ensure discount is always present
    );
  }
}
