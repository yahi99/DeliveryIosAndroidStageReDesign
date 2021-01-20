// To parse this JSON data, do
//
//     final filteredCities = filteredCitiesFromJson(jsonString);

import 'dart:convert';

List<FilteredCities> filteredCitiesFromJson(String str) => List<FilteredCities>.from(json.decode(str).map((x) => FilteredCities.fromJson(x)));

String filteredCitiesToJson(List<FilteredCities> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FilteredCities {
  FilteredCities({
    this.uuid,
    this.name,
    this.url,
    this.meta,
  });

  String uuid;
  String name;
  String url;
  Meta meta;

  factory FilteredCities.fromJson(Map<String, dynamic> json) => FilteredCities(
    uuid: json["uuid"],
    name: json["name"],
    url: json["url"],
    meta: Meta.fromJson(json["meta"]),
  );

  Map<String, dynamic> toJson() => {
    "uuid": uuid,
    "name": name,
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
