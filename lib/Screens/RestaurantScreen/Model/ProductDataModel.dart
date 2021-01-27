// To parse this JSON data, do
//
//     final productsDataModel = productsDataModelFromJson(jsonString);

import 'dart:convert';

ProductsDataModel productsDataModelFromJson(String str) => ProductsDataModel.fromJson(json.decode(str));

String productsDataModelToJson(ProductsDataModel data) => json.encode(data.toJson());

class ProductsDataModel {
  ProductsDataModel({
    this.uuid,
    this.name,
    this.storeUuid,
    this.comment,
    this.url,
    this.meta,
    this.productCategories,
    this.variantGroups,
  });

  String uuid;
  String name;
  String storeUuid;
  String comment;
  String url;
  ProductsDataModelMeta meta;
  List<ProductCategory> productCategories;
  List<VariantGroup> variantGroups;

  factory ProductsDataModel.fromJson(Map<String, dynamic> json) => ProductsDataModel(
    uuid: json["uuid"],
    name: json["name"],
    storeUuid: json["store_uuid"],
    comment: json["comment"],
    url: json["url"],
    meta: ProductsDataModelMeta.fromJson(json["meta"]),
    productCategories: List<ProductCategory>.from(json["product_categories"].map((x) => ProductCategory.fromJson(x))),
    variantGroups: List<VariantGroup>.from(json["variant_groups"].map((x) => VariantGroup.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "uuid": uuid,
    "name": name,
    "store_uuid": storeUuid,
    "comment": comment,
    "url": url,
    "meta": meta.toJson(),
    "product_categories": List<dynamic>.from(productCategories.map((x) => x.toJson())),
    "variant_groups": List<dynamic>.from(variantGroups.map((x) => x.toJson())),
  };
}

class ProductsDataModelMeta {
  ProductsDataModelMeta();

  factory ProductsDataModelMeta.fromJson(Map<String, dynamic> json) => ProductsDataModelMeta(
  );

  Map<String, dynamic> toJson() => {
  };
}

class ProductCategory {
  ProductCategory({
    this.uuid,
    this.name,
    this.priority,
    this.comment,
    this.url,
    this.meta,
  });

  String uuid;
  String name;
  int priority;
  String comment;
  String url;
  ProductsDataModelMeta meta;

  factory ProductCategory.fromJson(Map<String, dynamic> json) => ProductCategory(
    uuid: json["uuid"],
    name: json["name"],
    priority: json["priority"],
    comment: json["comment"],
    url: json["url"],
    meta: ProductsDataModelMeta.fromJson(json["meta"]),
  );

  Map<String, dynamic> toJson() => {
    "uuid": uuid,
    "name": name,
    "priority": priority,
    "comment": comment,
    "url": url,
    "meta": meta.toJson(),
  };
}

class VariantGroup {
  VariantGroup({
    this.uuid,
    this.name,
    this.productUuid,
    this.required,
    this.multiselect,
    this.description,
    this.meta,
    this.variants,
  });

  String uuid;
  String name;
  String productUuid;
  bool required;
  bool multiselect;
  String description;
  ProductsDataModelMeta meta;
  List<Variant> variants;

  factory VariantGroup.fromJson(Map<String, dynamic> json) => VariantGroup(
    uuid: json["uuid"],
    name: json["name"],
    productUuid: json["product_uuid"],
    required: json["required"],
    multiselect: json["multiselect"],
    description: json["description"],
    meta: ProductsDataModelMeta.fromJson(json["meta"]),
    variants: List<Variant>.from(json["variants"].map((x) => Variant.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "uuid": uuid,
    "name": name,
    "product_uuid": productUuid,
    "required": required,
    "multiselect": multiselect,
    "description": description,
    "meta": meta.toJson(),
    "variants": List<dynamic>.from(variants.map((x) => x.toJson())),
  };
}

class Variant {
  Variant({
    this.uuid,
    this.name,
    this.productUuid,
    this.variantGroupUuid,
    this.price,
    this.description,
    this.variantDefault,
    this.meta,
  });

  String uuid;
  String name;
  String productUuid;
  String variantGroupUuid;
  int price;
  String description;
  bool variantDefault;
  VariantMeta meta;

  factory Variant.fromJson(Map<String, dynamic> json) => Variant(
    uuid: json["uuid"],
    name: json["name"],
    productUuid: json["product_uuid"],
    variantGroupUuid: json["variant_group_uuid"],
    price: json["price"],
    description: json["description"],
    variantDefault: json["default"],
    meta: VariantMeta.fromJson(json["meta"]),
  );

  Map<String, dynamic> toJson() => {
    "uuid": uuid,
    "name": name,
    "product_uuid": productUuid,
    "variant_group_uuid": variantGroupUuid,
    "price": price,
    "description": description,
    "default": variantDefault,
    "meta": meta.toJson(),
  };
}

class VariantMeta {
  VariantMeta({
    this.description,
    this.images,
    this.energyValue,
  });

  String description;
  dynamic images;
  EnergyValue energyValue;

  factory VariantMeta.fromJson(Map<String, dynamic> json) => VariantMeta(
    description: json["description"],
    images: json["images"],
    energyValue: EnergyValue.fromJson(json["energy_value"]),
  );

  Map<String, dynamic> toJson() => {
    "description": description,
    "images": images,
    "energy_value": energyValue.toJson(),
  };
}

class EnergyValue {
  EnergyValue({
    this.protein,
    this.fat,
    this.carbohydrates,
    this.calories,
  });

  int protein;
  int fat;
  int carbohydrates;
  int calories;

  factory EnergyValue.fromJson(Map<String, dynamic> json) => EnergyValue(
    protein: json["protein"],
    fat: json["fat"],
    carbohydrates: json["carbohydrates"],
    calories: json["calories"],
  );

  Map<String, dynamic> toJson() => {
    "protein": protein,
    "fat": fat,
    "carbohydrates": carbohydrates,
    "calories": calories,
  };
}