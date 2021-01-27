class ProductsByStoreUuidData{
  List<ProductsByStoreUuid> productsByStoreUuidList;

  ProductsByStoreUuidData( {
    this.productsByStoreUuidList,
  });

  factory ProductsByStoreUuidData.fromJson(List<dynamic> parsedJson){
    List<ProductsByStoreUuid> productsList = null;
    if(parsedJson != null){
      productsList = parsedJson.map((i) => ProductsByStoreUuid.fromJson(i)).toList();
    }

    return ProductsByStoreUuidData(
      productsByStoreUuidList:productsList,
    );
  }
}


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
    productCategoriesUuid: (json["product_categories_uuid"] == null) ? null : List<String>.from(json["product_categories_uuid"].map((x) => x)),
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
