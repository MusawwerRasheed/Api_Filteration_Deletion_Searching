import 'dart:convert';

class Carts {
  final int? id;
  final int? userId;
  final DateTime? date;
  final List<Product>? products;
  final int? v;


  Carts({
    this.id,
    this.userId,
    this.date,
    this.products,
    this.v,
  });



  Carts copyWith({
    int? id,
    int? userId,
    DateTime? date,
    List<Product>? products,
    int? v,
  }) =>
      Carts(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        date: date ?? this.date,
        products: products ?? this.products,
        v: v ?? this.v,
      );

  factory Carts.fromRawJson(String str) => Carts.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Carts.fromJson(Map<String, dynamic> json) => Carts(
    id: json["id"],
    userId: json["userId"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    products: json["products"] == null ? [] : List<Product>.from(json["products"]!.map((x) => Product.fromJson(x))),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userId": userId,
    "date": date?.toIso8601String(),
    "products": products == null ? [] : List<dynamic>.from(products!.map((x) => x.toJson())),
    "__v": v,
  };
}

class Product {
  final int? productId;
  final int? quantity;

  Product({
    this.productId,
    this.quantity,
  });

  Product copyWith({
    int? productId,
    int? quantity,
  }) =>
      Product(
        productId: productId ?? this.productId,
        quantity: quantity ?? this.quantity,
      );

  factory Product.fromRawJson(String str) => Product.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    productId: json["productId"],
    quantity: json["quantity"],
  );

  Map<String, dynamic> toJson() => {
    "productId": productId,
    "quantity": quantity,
  };
}
