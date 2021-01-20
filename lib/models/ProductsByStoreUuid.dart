// To parse this JSON data, do
//
//     final productsByStoreUuid = productsByStoreUuidFromJson(jsonString);

import 'dart:convert';

List<ProductsByStoreUuid> productsByStoreUuidFromJson(String str) => List<ProductsByStoreUuid>.from(json.decode(str).map((x) => ProductsByStoreUuid.fromJson(x)));

String productsByStoreUuidToJson(List<ProductsByStoreUuid> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductsByStoreUuid {
  ProductsByStoreUuid({
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

  factory ProductsByStoreUuid.fromJson(Map<String, dynamic> json) => ProductsByStoreUuid(
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
