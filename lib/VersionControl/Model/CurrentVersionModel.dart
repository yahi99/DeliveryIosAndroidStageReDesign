import 'dart:convert';

CurrentVersionModel currentVersionModelFromJson(String str) => CurrentVersionModel.fromJson(json.decode(str));

String currentVersionModelToJson(CurrentVersionModel data) => json.encode(data.toJson());

class CurrentVersionModel {
  CurrentVersionModel({
    this.version,
    this.meta,
  });

  final String version;
  final Meta meta;

  factory CurrentVersionModel.fromJson(Map<String, dynamic> json) => CurrentVersionModel(
    version: json["version"] == null ? null : json["version"],
    meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
  );

  Map<String, dynamic> toJson() => {
    "version": version == null ? null : version,
    "meta": meta == null ? null : meta.toJson(),
  };
}

class Meta {
  Meta({
    this.description,
    this.link,
  });

  final String description;
  final String link;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    description: json["description"] == null ? null : json["description"],
    link: json["link"] == null ? null : json["link"],
  );

  Map<String, dynamic> toJson() => {
    "description": description == null ? null : description,
    "link": link == null ? null : link,
  };
}
