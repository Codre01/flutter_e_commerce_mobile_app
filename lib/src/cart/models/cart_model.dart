import 'dart:convert';

// Function to convert JSON string to List<CartModel>
List<CartModel> cartModelFromJson(String str) => List<CartModel>.from(json.decode(str).map((x) => CartModel.fromJson(x)));

// Function to convert List<CartModel> to JSON string
String cartModelToJson(List<CartModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CartModel {
  final int id;
  final Product product;
  final int quantity;
  final String size;
  final String color;

  CartModel({
    required this.id,
    required this.product,
    required this.quantity,
    required this.size,
    required this.color,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
    id: json["id"],
    product: Product.fromJson(json["product"]),
    quantity: json["quantity"],
    size: json["size"],
    color: json["color"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product": product.toJson(),
    "quantity": quantity,
    "size": size,
    "color": color,
  };
}

class Product {
  final int id;
  final String title;
  final double price;
  final String description;
  final bool isFeatured;
  final String clothesType;
  final double rating;
  final List<String> color;
  final List<String> sizes;
  final List<String> imageUrls;
  final DateTime createdAt;
  final int category;
  final int brand;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.isFeatured,
    required this.clothesType,
    required this.rating,
    required this.color,
    required this.sizes,
    required this.imageUrls,
    required this.createdAt,
    required this.category,
    required this.brand,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    title: json["title"],
    price: json["price"]?.toDouble() ?? 0.0,
    description: json["description"],
    isFeatured: json["is_featured"],
    clothesType: json["clothes_type"],
    rating: json["rating"]?.toDouble() ?? 0.0,
    color: List<String>.from(json["color"].map((x) => x)),
    sizes: List<String>.from(json["sizes"].map((x) => x)),
    imageUrls: List<String>.from(json["image_urls"].map((x) => x)),
    createdAt: DateTime.parse(json["created_at"]),
    category: json["category"],
    brand: json["brand"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "price": price,
    "description": description,
    "is_featured": isFeatured,
    "clothes_type": clothesType,
    "rating": rating,
    "color": List<dynamic>.from(color.map((x) => x)),
    "sizes": List<dynamic>.from(sizes.map((x) => x)),
    "image_urls": List<dynamic>.from(imageUrls.map((x) => x)),
    "created_at": createdAt.toIso8601String(),
    "category": category,
    "brand": brand,
  };
}
