import 'dart:convert';

CreateOrderModel createOrderModelFromJson(String str) => CreateOrderModel.fromJson(json.decode(str));

String createOrderModelToJson(CreateOrderModel data) => json.encode(data.toJson());

class CreateOrderModel {
    final int addressId;
    final List<Item> items;

    CreateOrderModel({
        required this.addressId,
        required this.items,
    });

    factory CreateOrderModel.fromJson(Map<String, dynamic> json) => CreateOrderModel(
        addressId: json["address_id"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "address_id": addressId,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
    };
}

class Item {
    final int productId;
    final int quantity;
    final double price;
    final String size;
    final String color;

    Item({
        required this.productId,
        required this.quantity,
        required this.price,
        required this.size,
        required this.color,
    });

    factory Item.fromJson(Map<String, dynamic> json) => Item(
        productId: json["product_id"],
        quantity: json["quantity"],
        price: json["price"]?.toDouble(),
        size: json["size"],
        color: json["color"],
    );

    Map<String, dynamic> toJson() => {
        "product_id": productId,
        "quantity": quantity,
        "price": price,
        "size": size,
        "color": color,
    };
}
