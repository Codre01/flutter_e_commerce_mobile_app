import 'dart:convert';

AddCartModel addCartModelFromJson(String str) => AddCartModel.fromJson(json.decode(str));

String addCartModelToJson(AddCartModel data) => json.encode(data.toJson());

class AddCartModel {
    final int product;
    final int quantity;
    final String size;
    final String color;

    AddCartModel({
        required this.product,
        required this.quantity,
        required this.size,
        required this.color,
    });

    factory AddCartModel.fromJson(Map<String, dynamic> json) => AddCartModel(
        product: json["product"],
        quantity: json["quantity"],
        size: json["size"],
        color: json["color"],
    );

    Map<String, dynamic> toJson() => {
        "product": product,
        "quantity": quantity,
        "size": size,
        "color": color,
    };
}
