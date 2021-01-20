// To parse this JSON data, do
//
//     final allStoreCategories = allStoreCategoriesFromJson(jsonString);

import 'dart:convert';

List<AllStoreCategories> allStoreCategoriesFromJson(String str) => List<AllStoreCategories>.from(json.decode(str).map((x) => AllStoreCategories.fromJson(x)));

String allStoreCategoriesToJson(List<AllStoreCategories> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllStoreCategories {
  AllStoreCategories({
    this.uuid,
    this.name,
    this.url,
    this.meta,
    this.priority,
  });

  String uuid;
  String name;
  String url;
  Meta meta;
  int priority;

  factory AllStoreCategories.fromJson(Map<String, dynamic> json) => AllStoreCategories(
    uuid: json["uuid"],
    name: json["name"],
    url: json["url"],
    meta: Meta.fromJson(json["meta"]),
    priority: json["priority"],
  );

  Map<String, dynamic> toJson() => {
    "uuid": uuid,
    "name": name,
    "url": url,
    "meta": meta.toJson(),
    "priority": priority,
  };
}

class Meta {
  Meta();

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
  );

  Map<String, dynamic> toJson() => {
  };
}
