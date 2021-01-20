// To parse this JSON data, do
//
//     final filteredStores = filteredStoresFromJson(jsonString);

import 'dart:convert';

List<FilteredStores> filteredStoresFromJson(String str) => List<FilteredStores>.from(json.decode(str).map((x) => FilteredStores.fromJson(x)));

String filteredStoresToJson(List<FilteredStores> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FilteredStores {
  FilteredStores({
    this.uuid,
    this.name,
    this.storeCategoriesUuid,
    this.productCategoriesUuid,
    this.paymentTypes,
    this.cityUuid,
    this.legalEntityUuid,
    this.parentUuid,
    this.type,
    this.workSchedule,
    this.address,
    this.contacts,
    this.priority,
    this.lat,
    this.lon,
    this.url,
    this.meta,
  });

  String uuid;
  String name;
  List<String> storeCategoriesUuid;
  List<String> productCategoriesUuid;
  List<PaymentType> paymentTypes;
  String cityUuid;
  String legalEntityUuid;
  String parentUuid;
  String type;
  dynamic workSchedule;
  Address address;
  dynamic contacts;
  int priority;
  int lat;
  int lon;
  String url;
  Meta meta;

  factory FilteredStores.fromJson(Map<String, dynamic> json) => FilteredStores(
    uuid: json["uuid"],
    name: json["name"],
    storeCategoriesUuid: List<String>.from(json["store_categories_uuid"].map((x) => x)),
    productCategoriesUuid: List<String>.from(json["product_categories_uuid"].map((x) => x)),
    paymentTypes: List<PaymentType>.from(json["payment_types"].map((x) => paymentTypeValues.map[x])),
    cityUuid: json["city_uuid"],
    legalEntityUuid: json["legal_entity_uuid"],
    parentUuid: json["parent_uuid"],
    type: json["type"],
    workSchedule: json["work_schedule"],
    address: Address.fromJson(json["address"]),
    contacts: json["contacts"],
    priority: json["priority"],
    lat: json["lat"],
    lon: json["lon"],
    url: json["url"],
    meta: Meta.fromJson(json["meta"]),
  );

  Map<String, dynamic> toJson() => {
    "uuid": uuid,
    "name": name,
    "store_categories_uuid": List<dynamic>.from(storeCategoriesUuid.map((x) => x)),
    "product_categories_uuid": List<dynamic>.from(productCategoriesUuid.map((x) => x)),
    "payment_types": List<dynamic>.from(paymentTypes.map((x) => paymentTypeValues.reverse[x])),
    "city_uuid": cityUuid,
    "legal_entity_uuid": legalEntityUuid,
    "parent_uuid": parentUuid,
    "type": type,
    "work_schedule": workSchedule,
    "address": address.toJson(),
    "contacts": contacts,
    "priority": priority,
    "lat": lat,
    "lon": lon,
    "url": url,
    "meta": meta.toJson(),
  };
}

class Address {
  Address({
    this.uuid,
    this.pointType,
    this.unrestrictedValue,
    this.value,
    this.country,
    this.region,
    this.regionType,
    this.type,
    this.city,
    this.cityType,
    this.street,
    this.streetType,
    this.streetWithType,
    this.house,
    this.frontDoor,
    this.comment,
    this.outOfTown,
    this.houseType,
    this.accuracyLevel,
    this.radius,
    this.lat,
    this.lon,
  });

  String uuid;
  String pointType;
  String unrestrictedValue;
  String value;
  String country;
  String region;
  String regionType;
  String type;
  String city;
  String cityType;
  String street;
  String streetType;
  String streetWithType;
  String house;
  int frontDoor;
  String comment;
  bool outOfTown;
  String houseType;
  int accuracyLevel;
  int radius;
  int lat;
  int lon;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    uuid: json["uuid"],
    pointType: json["point_type"],
    unrestrictedValue: json["unrestricted_value"],
    value: json["value"],
    country: json["country"],
    region: json["region"],
    regionType: json["region_type"],
    type: json["type"],
    city: json["city"],
    cityType: json["city_type"],
    street: json["street"],
    streetType: json["street_type"],
    streetWithType: json["street_with_type"],
    house: json["house"],
    frontDoor: json["front_door"],
    comment: json["comment"],
    outOfTown: json["out_of_town"],
    houseType: json["house_type"],
    accuracyLevel: json["accuracy_level"],
    radius: json["radius"],
    lat: json["lat"],
    lon: json["lon"],
  );

  Map<String, dynamic> toJson() => {
    "uuid": uuid,
    "point_type": pointType,
    "unrestricted_value": unrestrictedValue,
    "value": value,
    "country": country,
    "region": region,
    "region_type": regionType,
    "type": type,
    "city": city,
    "city_type": cityType,
    "street": street,
    "street_type": streetType,
    "street_with_type": streetWithType,
    "house": house,
    "front_door": frontDoor,
    "comment": comment,
    "out_of_town": outOfTown,
    "house_type": houseType,
    "accuracy_level": accuracyLevel,
    "radius": radius,
    "lat": lat,
    "lon": lon,
  };
}

class Meta {
  Meta();

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
  );

  Map<String, dynamic> toJson() => {
  };
}

enum PaymentType { CASH, CARD }

final paymentTypeValues = EnumValues({
  "card": PaymentType.CARD,
  "cash": PaymentType.CASH
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
