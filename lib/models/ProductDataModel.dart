// To parse this JSON data, do
//
//     final productDataModel = productDataModelFromJson(jsonString);

import 'dart:convert';

ProductDataModel productDataModelFromJson(String str) => ProductDataModel.fromJson(json.decode(str));

String productDataModelToJson(ProductDataModel data) => json.encode(data.toJson());

class ProductDataModel {
  ProductDataModel({
    this.product,
    this.variants,
  });

  Product product;
  dynamic variants;

  factory ProductDataModel.fromJson(Map<String, dynamic> json) => ProductDataModel(
    product: Product.fromJson(json["product"]),
    variants: json["variants"],
  );

  Map<String, dynamic> toJson() => {
    "product": product.toJson(),
    "variants": variants,
  };
}

class Product {
  Product({
    this.uuid,
    this.name,
    this.storeUuid,
    this.productCategoriesUuid,
    this.comment,
    this.url,
    this.meta,
  });

  String uuid;
  String name;
  String storeUuid;
  List<String> productCategoriesUuid;
  String comment;
  String url;
  Meta meta;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    uuid: json["uuid"],
    name: json["name"],
    storeUuid: json["store_uuid"],
    productCategoriesUuid: List<String>.from(json["product_categories_uuid"].map((x) => x)),
    comment: json["comment"],
    url: json["url"],
    meta: Meta.fromJson(json["meta"]),
  );

  Map<String, dynamic> toJson() => {
    "uuid": uuid,
    "name": name,
    "store_uuid": storeUuid,
    "product_categories_uuid": List<dynamic>.from(productCategoriesUuid.map((x) => x)),
    "comment": comment,
    "url": url,
    "meta": meta.toJson(),
  };
}

class Meta {
  Meta();

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
  );

  Map<String, dynamic> toJson() => {
  };
}
