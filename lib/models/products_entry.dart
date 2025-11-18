// To parse this JSON data, do
//
//     final productsEntry = productsEntryFromJson(jsonString);

import 'dart:convert';

List<ProductsEntry> productsEntryFromJson(String str) => List<ProductsEntry>.from(json.decode(str).map((x) => ProductsEntry.fromJson(x)));

String productsEntryToJson(List<ProductsEntry> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductsEntry {
    String model;
    String pk;
    Fields fields;

    ProductsEntry({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory ProductsEntry.fromJson(Map<String, dynamic> json) => ProductsEntry(
        model: json["model"],
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
    );

    Map<String, dynamic> toJson() => {
        "model": model,
        "pk": pk,
        "fields": fields.toJson(),
    };
}

class Fields {
    int user;
    String name;
    int price;
    String description;
    String thumbnail1;
    dynamic thumbnail2;
    dynamic thumbnail3;
    String category;
    bool isFeatured;
    int stock;
    int rating;
    dynamic brand;
    String brandName;
    DateTime createdAt;
    int visitors;

    Fields({
        required this.user,
        required this.name,
        required this.price,
        required this.description,
        required this.thumbnail1,
        required this.thumbnail2,
        required this.thumbnail3,
        required this.category,
        required this.isFeatured,
        required this.stock,
        required this.rating,
        required this.brand,
        required this.brandName,
        required this.createdAt,
        required this.visitors,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: json["user"],
        name: json["name"],
        price: json["price"],
        description: json["description"],
        thumbnail1: json["thumbnail1"],
        thumbnail2: json["thumbnail2"],
        thumbnail3: json["thumbnail3"],
        category: json["category"],
        isFeatured: json["is_featured"],
        stock: json["stock"],
        rating: json["rating"],
        brand: json["brand"],
        brandName: json["brandName"],
        createdAt: DateTime.parse(json["created_at"]),
        visitors: json["visitors"],
    );

    Map<String, dynamic> toJson() => {
        "user": user,
        "name": name,
        "price": price,
        "description": description,
        "thumbnail1": thumbnail1,
        "thumbnail2": thumbnail2,
        "thumbnail3": thumbnail3,
        "category": category,
        "is_featured": isFeatured,
        "stock": stock,
        "rating": rating,
        "brand": brand,
        "brandName": brandName,
        "created_at": createdAt.toIso8601String(),
        "visitors": visitors,
    };
}
