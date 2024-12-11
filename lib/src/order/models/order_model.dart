
import 'dart:convert';

List<OrderModel> ordersFromJson(String jsonString) {
    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((json) => OrderModel.fromJson(json)).toList();
  }

  OrderModel orderFromJson(String jsonString) {
    final Map<String, dynamic> jsonMap = json.decode(jsonString);
    return OrderModel.fromJson(jsonMap);
  }

class OrderModel {
  final int id;
  final String totalAmount;
  final String status;
  final String paymentStatus;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<OrderItemModel> items;
  final AddressModel address;

  OrderModel({
    required this.id,
    required this.totalAmount,
    required this.status,
    required this.paymentStatus,
    required this.createdAt,
    required this.updatedAt,
    required this.items,
    required this.address,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      totalAmount: json['total_amount'],
      status: json['status'],
      paymentStatus: json['payment_status'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      items: (json['items'] as List)
          .map((item) => OrderItemModel.fromJson(item))
          .toList(),
      address: AddressModel.fromJson(json['address']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'total_amount': totalAmount,
      'status': status,
      'payment_status': paymentStatus,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'items': items.map((item) => item.toJson()).toList(),
      'address': address.toJson(),
    };
  }
}

class OrderItemModel {
  final int id;
  final int quantity;
  final String price;
  final String size;
  final String color;
  final ProductModel product;

  OrderItemModel({
    required this.id,
    required this.quantity,
    required this.price,
    required this.size,
    required this.color,
    required this.product,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      id: json['id'],
      quantity: json['quantity'],
      price: json['price'],
      size: json['size'],
      color: json['color'],
      product: ProductModel.fromJson(json['product']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'quantity': quantity,
      'price': price,
      'size': size,
      'color': color,
      'product': product.toJson(),
    };
  }
}

class ProductModel {
  final int id;
  final String title;
  final double price;
  final String description;
  final bool isFeatured;
  final String clothesType;
  final double rating;
  final List<String> colors;
  final List<String> sizes;
  final List<String> imageUrls;
  final DateTime createdAt;
  final int category;
  final int brand;

  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.isFeatured,
    required this.clothesType,
    required this.rating,
    required this.colors,
    required this.sizes,
    required this.imageUrls,
    required this.createdAt,
    required this.category,
    required this.brand,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      title: json['title'],
      price: json['price'].toDouble(),
      description: json['description'],
      isFeatured: json['is_featured'],
      clothesType: json['clothes_type'],
      rating: json['rating'].toDouble(),
      colors: List<String>.from(json['color']),
      sizes: List<String>.from(json['sizes']),
      imageUrls: List<String>.from(json['image_urls']),
      createdAt: DateTime.parse(json['created_at']),
      category: json['category'],
      brand: json['brand'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'description': description,
      'is_featured': isFeatured,
      'clothes_type': clothesType,
      'rating': rating,
      'color': colors,
      'sizes': sizes,
      'image_urls': imageUrls,
      'created_at': createdAt.toIso8601String(),
      'category': category,
      'brand': brand,
    };
  }
}

class AddressModel {
  final int id;
  final bool isDefault;
  final String address;
  final String phone;
  final String addressType;
  final int userId;

  AddressModel({
    required this.id,
    required this.isDefault,
    required this.address,
    required this.phone,
    required this.addressType,
    required this.userId,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['id'],
      isDefault: json['is_default'],
      address: json['address'],
      phone: json['phone'],
      addressType: json['address_type'],
      userId: json['user_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'is_default': isDefault,
      'address': address,
      'phone': phone,
      'address_type': addressType,
      'user_id': userId,
    };
  }
}