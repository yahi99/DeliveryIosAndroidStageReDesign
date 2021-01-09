// To parse this JSON data, do
//
//     final initData = initDataFromJson(jsonString);

import 'dart:convert';

import 'package:flutter_app/models/ResponseData.dart';

InitData initDataFromJson(String str) => InitData.fromJson(json.decode(str));

String initDataToJson(InitData data) => json.encode(data.toJson());

class InitData {
  InitData({
    this.clientUuid,
    this.clientPhone,
    this.defaultPaymentType,
    this.referralCode,
    this.ordersData,
  });

  String clientUuid;
  String clientPhone;
  String defaultPaymentType;
  String referralCode;
  List<OrdersDatum> ordersData;

  factory InitData.fromJson(Map<String, dynamic> json) => InitData(
    clientUuid: json["client_uuid"],
    clientPhone: json["client_phone"],
    defaultPaymentType: json["default_payment_type"],
    referralCode: json["referral_code"],
    ordersData: (json["orders_data"] == null) ? null : List<OrdersDatum>.from(json["orders_data"].map((x) => OrdersDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "client_uuid": clientUuid,
    "client_phone": clientPhone,
    "default_payment_type": defaultPaymentType,
    "referral_code": referralCode,
    "orders_data": List<dynamic>.from(ordersData.map((x) => x.toJson())),
  };
}

class OrdersDatum {
  OrdersDatum({
    this.uuid,
    this.comment,
    this.routes,
    this.routeWayData,
    this.features,
    this.tariff,
    this.phoneLine,
    this.fixedPrice,
    this.service,
    this.increasedFare,
    this.driver,
    this.client,
    this.source,
    this.driverRating,
    this.clientRating,
    this.isOptional,
    this.withoutDelivery,
    this.ownDelivery,
    this.orderStart,
    this.cancelTime,
    this.distributionByTaxiPark,
    this.promotion,
    this.arrivalTime,
    this.productsData,
    this.paymentType,
    this.paymentMeta,
    this.estimatedDeliveryTime,
    this.taxiParkData,
    this.taxiParkUuid,
    this.id,
    this.clientUuid,
    this.serviceUuid,
    this.callbackPhone,
    this.featuresUuids,
    this.createdAt,
    this.createdAtUnix,
    this.updatedAt,
    this.visibility,
    this.state,
    this.stateTitle,
  });

  String uuid;
  String comment;
  List<DestinationPoints> routes;
  RouteWayData routeWayData;
  dynamic features;
  OrdersDatumTariff tariff;
  PhoneLine phoneLine;
  int fixedPrice;
  Service service;
  int increasedFare;
  Driver driver;
  Client client;
  String source;
  Rating driverRating;
  Rating clientRating;
  bool isOptional;
  bool withoutDelivery;
  bool ownDelivery;
  DateTime orderStart;
  DateTime cancelTime;
  dynamic distributionByTaxiPark;
  OrdersDatumPromotion promotion;
  int arrivalTime;
  ProductsData productsData;
  String paymentType;
  PaymentMeta paymentMeta;
  DateTime estimatedDeliveryTime;
  TaxiParkData taxiParkData;
  dynamic taxiParkUuid;
  int id;
  String clientUuid;
  String serviceUuid;
  String callbackPhone;
  dynamic featuresUuids;
  DateTime createdAt;
  int createdAtUnix;
  DateTime updatedAt;
  bool visibility;
  String state;
  String stateTitle;

  factory OrdersDatum.fromJson(Map<String, dynamic> json) => OrdersDatum(
    uuid: json["uuid"],
    comment: json["comment"],
    routes: List<DestinationPoints>.from(json["routes"].map((x) => DestinationPoints.fromJson(x))),
    routeWayData: RouteWayData.fromJson(json["route_way_data"]),
    features: json["features"],
    tariff: OrdersDatumTariff.fromJson(json["tariff"]),
    phoneLine: PhoneLine.fromJson(json["phone_line"]),
    fixedPrice: json["fixed_price"],
    service: Service.fromJson(json["service"]),
    increasedFare: json["increased_fare"],
    driver: Driver.fromJson(json["driver"]),
    client: Client.fromJson(json["client"]),
    source: json["source"],
    driverRating: Rating.fromJson(json["driver_rating"]),
    clientRating: Rating.fromJson(json["client_rating"]),
    isOptional: json["is_optional"],
    withoutDelivery: json["without_delivery"],
    ownDelivery: json["own_delivery"],
    orderStart: DateTime.parse(json["order_start"]),
    cancelTime: DateTime.parse(json["cancel_time"]),
    distributionByTaxiPark: json["distribution_by_taxi_park"],
    promotion: OrdersDatumPromotion.fromJson(json["promotion"]),
    arrivalTime: json["arrival_time"],
    productsData: ProductsData.fromJson(json["products_data"]),
    paymentType: json["payment_type"],
    paymentMeta: PaymentMeta.fromJson(json["payment_meta"]),
    estimatedDeliveryTime: DateTime.parse(json["estimated_delivery_time"]),
    taxiParkData: TaxiParkData.fromJson(json["taxi_park_data"]),
    taxiParkUuid: json["taxi_park_uuid"],
    id: json["id"],
    clientUuid: json["client_uuid"],
    serviceUuid: json["service_uuid"],
    callbackPhone: json["callback_phone"],
    featuresUuids: json["features_uuids"],
    createdAt: DateTime.parse(json["created_at"]),
    createdAtUnix: json["created_at_unix"],
    updatedAt: DateTime.parse(json["updated_at"]),
    visibility: json["visibility"],
    state: json["state"],
    stateTitle: json["state_title"],
  );

  Map<String, dynamic> toJson() => {
    "uuid": uuid,
    "comment": comment,
    "routes": List<dynamic>.from(routes.map((x) => x.toJson())),
    "route_way_data": routeWayData.toJson(),
    "features": features,
    "tariff": tariff.toJson(),
    "phone_line": phoneLine.toJson(),
    "fixed_price": fixedPrice,
    "service": service.toJson(),
    "increased_fare": increasedFare,
    "driver": driver.toJson(),
    "client": client.toJson(),
    "source": source,
    "driver_rating": driverRating.toJson(),
    "client_rating": clientRating.toJson(),
    "is_optional": isOptional,
    "without_delivery": withoutDelivery,
    "own_delivery": ownDelivery,
    "order_start": orderStart.toIso8601String(),
    "cancel_time": cancelTime.toIso8601String(),
    "distribution_by_taxi_park": distributionByTaxiPark,
    "promotion": promotion.toJson(),
    "arrival_time": arrivalTime,
    "products_data": productsData.toJson(),
    "payment_type": paymentType,
    "payment_meta": paymentMeta.toJson(),
    "estimated_delivery_time": estimatedDeliveryTime.toIso8601String(),
    "taxi_park_data": taxiParkData.toJson(),
    "taxi_park_uuid": taxiParkUuid,
    "id": id,
    "client_uuid": clientUuid,
    "service_uuid": serviceUuid,
    "callback_phone": callbackPhone,
    "features_uuids": featuresUuids,
    "created_at": createdAt.toIso8601String(),
    "created_at_unix": createdAtUnix,
    "updated_at": updatedAt.toIso8601String(),
    "visibility": visibility,
    "state": state,
    "state_title": stateTitle,
  };
}

class Client {
  Client({
    this.uuid,
    this.name,
    this.karma,
    this.mainPhone,
    this.blocked,
    this.phones,
    this.deviceId,
    this.telegramId,
    this.comment,
    this.activity,
    this.defaultPaymentType,
    this.promotion,
    this.referralProgramData,
    this.blacklist,
  });

  String uuid;
  String name;
  int karma;
  String mainPhone;
  bool blocked;
  dynamic phones;
  String deviceId;
  String telegramId;
  String comment;
  int activity;
  String defaultPaymentType;
  ClientPromotion promotion;
  ReferralProgramData referralProgramData;
  dynamic blacklist;

  factory Client.fromJson(Map<String, dynamic> json) => Client(
    uuid: json["uuid"],
    name: json["name"],
    karma: json["karma"],
    mainPhone: json["main_phone"],
    blocked: json["blocked"],
    phones: json["phones"],
    deviceId: json["device_id"],
    telegramId: json["telegram_id"],
    comment: json["comment"],
    activity: json["activity"],
    defaultPaymentType: json["default_payment_type"],
    promotion: ClientPromotion.fromJson(json["promotion"]),
    referralProgramData: ReferralProgramData.fromJson(json["referral_program_data"]),
    blacklist: json["blacklist"],
  );

  Map<String, dynamic> toJson() => {
    "uuid": uuid,
    "name": name,
    "karma": karma,
    "main_phone": mainPhone,
    "blocked": blocked,
    "phones": phones,
    "device_id": deviceId,
    "telegram_id": telegramId,
    "comment": comment,
    "activity": activity,
    "default_payment_type": defaultPaymentType,
    "promotion": promotion.toJson(),
    "referral_program_data": referralProgramData.toJson(),
    "blacklist": blacklist,
  };
}

class ClientPromotion {
  ClientPromotion({
    this.booster,
    this.isVip,
  });

  bool booster;
  bool isVip;

  factory ClientPromotion.fromJson(Map<String, dynamic> json) => ClientPromotion(
    booster: json["booster"],
    isVip: json["is_vip"],
  );

  Map<String, dynamic> toJson() => {
    "booster": booster,
    "is_vip": isVip,
  };
}

class ReferralProgramData {
  ReferralProgramData({
    this.enable,
    this.referralCode,
    this.parentUuid,
    this.referralParentCode,
    this.referralParentPhone,
    this.activationCount,
    this.recipientsTravelCount,
    this.isNewcomer,
  });

  bool enable;
  String referralCode;
  String parentUuid;
  String referralParentCode;
  String referralParentPhone;
  int activationCount;
  int recipientsTravelCount;
  bool isNewcomer;

  factory ReferralProgramData.fromJson(Map<String, dynamic> json) => ReferralProgramData(
    enable: json["enable"],
    referralCode: json["referral_code"],
    parentUuid: json["parent_uuid"],
    referralParentCode: json["referral_parent_code"],
    referralParentPhone: json["referral_parent_phone"],
    activationCount: json["activation_count"],
    recipientsTravelCount: json["recipients_travel_count"],
    isNewcomer: json["is_newcomer"],
  );

  Map<String, dynamic> toJson() => {
    "enable": enable,
    "referral_code": referralCode,
    "parent_uuid": parentUuid,
    "referral_parent_code": referralParentCode,
    "referral_parent_phone": referralParentPhone,
    "activation_count": activationCount,
    "recipients_travel_count": recipientsTravelCount,
    "is_newcomer": isNewcomer,
  };
}

class Rating {
  Rating({
    this.value,
    this.comment,
  });

  int value;
  String comment;

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
    value: json["value"],
    comment: json["comment"],
  );

  Map<String, dynamic> toJson() => {
    "value": value,
    "comment": comment,
  };
}

class Driver {
  Driver({
    this.uuid,
    this.name,
    this.paymentTypes,
    this.phone,
    this.comment,
    this.stateName,
    this.car,
    this.balance,
    this.cardBalance,
    this.karma,
    this.color,
    this.tariff,
    this.tag,
    this.availableServices,
    this.availableFeatures,
    this.alias,
    this.regNumber,
    this.activity,
    this.promotion,
    this.group,
    this.blacklist,
    this.meta,
    this.counterOrderSwitch,
    this.taxiParkData,
    this.taxiParkUuid,
  });

  String uuid;
  String name;
  dynamic paymentTypes;
  String phone;
  String comment;
  String stateName;
  String car;
  int balance;
  int cardBalance;
  int karma;
  String color;
  DriverTariff tariff;
  dynamic tag;
  dynamic availableServices;
  dynamic availableFeatures;
  int alias;
  String regNumber;
  int activity;
  DriverPromotion promotion;
  Group group;
  dynamic blacklist;
  Meta meta;
  dynamic counterOrderSwitch;
  TaxiParkData taxiParkData;
  dynamic taxiParkUuid;

  factory Driver.fromJson(Map<String, dynamic> json) => Driver(
    uuid: json["uuid"],
    name: json["name"],
    paymentTypes: json["payment_types"],
    phone: json["phone"],
    comment: json["comment"],
    stateName: json["state_name"],
    car: json["car"],
    balance: json["balance"],
    cardBalance: json["card_balance"],
    karma: json["karma"],
    color: json["color"],
    tariff: DriverTariff.fromJson(json["tariff"]),
    tag: json["tag"],
    availableServices: json["available_services"],
    availableFeatures: json["available_features"],
    alias: json["alias"],
    regNumber: json["reg_number"],
    activity: json["activity"],
    promotion: DriverPromotion.fromJson(json["promotion"]),
    group: Group.fromJson(json["group"]),
    blacklist: json["blacklist"],
    meta: Meta.fromJson(json["meta"]),
    counterOrderSwitch: json["counter_order_switch"],
    taxiParkData: TaxiParkData.fromJson(json["taxi_park_data"]),
    taxiParkUuid: json["taxi_park_uuid"],
  );

  Map<String, dynamic> toJson() => {
    "uuid": uuid,
    "name": name,
    "payment_types": paymentTypes,
    "phone": phone,
    "comment": comment,
    "state_name": stateName,
    "car": car,
    "balance": balance,
    "card_balance": cardBalance,
    "karma": karma,
    "color": color,
    "tariff": tariff.toJson(),
    "tag": tag,
    "available_services": availableServices,
    "available_features": availableFeatures,
    "alias": alias,
    "reg_number": regNumber,
    "activity": activity,
    "promotion": promotion.toJson(),
    "group": group.toJson(),
    "blacklist": blacklist,
    "meta": meta.toJson(),
    "counter_order_switch": counterOrderSwitch,
    "taxi_park_data": taxiParkData.toJson(),
    "taxi_park_uuid": taxiParkUuid,
  };
}

class Group {
  Group({
    this.uuid,
    this.name,
    this.description,
    this.distributionWeight,
    this.servicesUuid,
    this.photocontrolTemplates,
    this.tag,
    this.defaultTariffUuid,
    this.defaultTariffOfflineUuid,
  });

  String uuid;
  String name;
  String description;
  int distributionWeight;
  dynamic servicesUuid;
  dynamic photocontrolTemplates;
  dynamic tag;
  String defaultTariffUuid;
  String defaultTariffOfflineUuid;

  factory Group.fromJson(Map<String, dynamic> json) => Group(
    uuid: json["uuid"],
    name: json["name"],
    description: json["description"],
    distributionWeight: json["distribution_weight"],
    servicesUuid: json["services_uuid"],
    photocontrolTemplates: json["photocontrol_templates"],
    tag: json["tag"],
    defaultTariffUuid: json["default_tariff_uuid"],
    defaultTariffOfflineUuid: json["default_tariff_offline_uuid"],
  );

  Map<String, dynamic> toJson() => {
    "uuid": uuid,
    "name": name,
    "description": description,
    "distribution_weight": distributionWeight,
    "services_uuid": servicesUuid,
    "photocontrol_templates": photocontrolTemplates,
    "tag": tag,
    "default_tariff_uuid": defaultTariffUuid,
    "default_tariff_offline_uuid": defaultTariffOfflineUuid,
  };
}

class Meta {
  Meta({
    this.blockedAt,
    this.blockedUntil,
    this.unblockedAt,
  });

  int blockedAt;
  int blockedUntil;
  int unblockedAt;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    blockedAt: json["blocked_at"],
    blockedUntil: json["blocked_until"],
    unblockedAt: json["unblocked_at"],
  );

  Map<String, dynamic> toJson() => {
    "blocked_at": blockedAt,
    "blocked_until": blockedUntil,
    "unblocked_at": unblockedAt,
  };
}

class DriverPromotion {
  DriverPromotion({
    this.booster,
    this.rentedAuto,
    this.brandSticker,
    this.haveOrder,
  });

  bool booster;
  bool rentedAuto;
  bool brandSticker;
  bool haveOrder;

  factory DriverPromotion.fromJson(Map<String, dynamic> json) => DriverPromotion(
    booster: json["booster"],
    rentedAuto: json["rented_auto"],
    brandSticker: json["brand_sticker"],
    haveOrder: json["have_order"],
  );

  Map<String, dynamic> toJson() => {
    "booster": booster,
    "rented_auto": rentedAuto,
    "brand_sticker": brandSticker,
    "have_order": haveOrder,
  };
}

class DriverTariff {
  DriverTariff({
    this.uuid,
    this.offline,
    this.driversGroupsUuid,
    this.tariffDefault,
    this.isSecret,
    this.tariffType,
    this.name,
    this.comment,
    this.color,
    this.rejExp,
    this.commExp,
    this.period,
    this.periodPrice,
    this.payedAt,
  });

  String uuid;
  bool offline;
  dynamic driversGroupsUuid;
  bool tariffDefault;
  bool isSecret;
  String tariffType;
  String name;
  String comment;
  String color;
  String rejExp;
  String commExp;
  int period;
  int periodPrice;
  int payedAt;

  factory DriverTariff.fromJson(Map<String, dynamic> json) => DriverTariff(
    uuid: json["uuid"],
    offline: json["offline"],
    driversGroupsUuid: json["drivers_groups_uuid"],
    tariffDefault: json["default"],
    isSecret: json["is_secret"],
    tariffType: json["tariff_type"],
    name: json["name"],
    comment: json["comment"],
    color: json["color"],
    rejExp: json["rej_exp"],
    commExp: json["comm_exp"],
    period: json["period"],
    periodPrice: json["period_price"],
    payedAt: json["payed_at"],
  );

  Map<String, dynamic> toJson() => {
    "uuid": uuid,
    "offline": offline,
    "drivers_groups_uuid": driversGroupsUuid,
    "default": tariffDefault,
    "is_secret": isSecret,
    "tariff_type": tariffType,
    "name": name,
    "comment": comment,
    "color": color,
    "rej_exp": rejExp,
    "comm_exp": commExp,
    "period": period,
    "period_price": periodPrice,
    "payed_at": payedAt,
  };
}

class TaxiParkData {
  TaxiParkData({
    this.uuid,
    this.name,
    this.comment,
    this.friendlyUuid,
    this.unwantedUuid,
    this.regionUuid,
    this.representative,
  });

  String uuid;
  String name;
  String comment;
  dynamic friendlyUuid;
  dynamic unwantedUuid;
  String regionUuid;
  Representative representative;

  factory TaxiParkData.fromJson(Map<String, dynamic> json) => TaxiParkData(
    uuid: json["uuid"],
    name: json["name"],
    comment: json["comment"],
    friendlyUuid: json["friendly_uuid"],
    unwantedUuid: json["unwanted_uuid"],
    regionUuid: json["region_uuid"],
    representative: Representative.fromJson(json["representative"]),
  );

  Map<String, dynamic> toJson() => {
    "uuid": uuid,
    "name": name,
    "comment": comment,
    "friendly_uuid": friendlyUuid,
    "unwanted_uuid": unwantedUuid,
    "region_uuid": regionUuid,
    "representative": representative.toJson(),
  };
}

class Representative {
  Representative({
    this.name,
    this.inn,
  });

  String name;
  String inn;

  factory Representative.fromJson(Map<String, dynamic> json) => Representative(
    name: json["name"],
    inn: json["inn"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "inn": inn,
  };
}

class PaymentMeta {
  PaymentMeta({
    this.isPrepaid,
    this.receiptUrl,
    this.qrCodeUrl,
    this.additionalData,
  });

  bool isPrepaid;
  String receiptUrl;
  String qrCodeUrl;
  dynamic additionalData;

  factory PaymentMeta.fromJson(Map<String, dynamic> json) => PaymentMeta(
    isPrepaid: json["_is_prepaid"],
    receiptUrl: json["receipt_url"],
    qrCodeUrl: json["qr_code_url"],
    additionalData: json["additional_data"],
  );

  Map<String, dynamic> toJson() => {
    "_is_prepaid": isPrepaid,
    "receipt_url": receiptUrl,
    "qr_code_url": qrCodeUrl,
    "additional_data": additionalData,
  };
}

class PhoneLine {
  PhoneLine({
    this.uuid,
    this.serviceUuid,
    this.name,
    this.comment,
  });

  String uuid;
  String serviceUuid;
  String name;
  String comment;

  factory PhoneLine.fromJson(Map<String, dynamic> json) => PhoneLine(
    uuid: json["uuid"],
    serviceUuid: json["service_uuid"],
    name: json["name"],
    comment: json["comment"],
  );

  Map<String, dynamic> toJson() => {
    "uuid": uuid,
    "service_uuid": serviceUuid,
    "name": name,
    "comment": comment,
  };
}

class ProductsData {
  ProductsData({
    this.store,
    this.preparationTime,
    this.confirmationTime,
    this.buyout,
    this.orderNumberInStore,
    this.products,
  });

  Store store;
  int preparationTime;
  int confirmationTime;
  bool buyout;
  String orderNumberInStore;
  List<Product> products;

  factory ProductsData.fromJson(Map<String, dynamic> json) => ProductsData(
    store: Store.fromJson(json["store"]),
    preparationTime: json["preparation_time"],
    confirmationTime: json["confirmation_time"],
    buyout: json["buyout"],
    orderNumberInStore: json["order_number_in_store"],
    products: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "store": store.toJson(),
    "preparation_time": preparationTime,
    "confirmation_time": confirmationTime,
    "buyout": buyout,
    "order_number_in_store": orderNumberInStore,
    "products": List<dynamic>.from(products.map((x) => x.toJson())),
  };
}

class Product {
  Product({
    this.uuid,
    this.weight,
    this.weightMeasure,
    this.name,
    this.comment,
    this.available,
    this.visible,
    this.price,
    this.image,
    this.storeUuid,
    this.toppings,
    this.number,
    this.selectedVariant,
  });

  String uuid;
  String weight;
  String weightMeasure;
  String name;
  String comment;
  bool available;
  bool visible;
  int price;
  String image;
  String storeUuid;
  dynamic toppings;
  int number;
  SelectedVariant selectedVariant;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    uuid: json["uuid"],
    weight: json["weight"],
    weightMeasure: json["weight_measure"],
    name: json["name"],
    comment: json["comment"],
    available: json["available"],
    visible: json["visible"],
    price: json["price"],
    image: json["image"],
    storeUuid: json["store_uuid"],
    toppings: json["toppings"],
    number: json["number"],
    selectedVariant: SelectedVariant.fromJson(json["selected_variant"]),
  );

  Map<String, dynamic> toJson() => {
    "uuid": uuid,
    "weight": weight,
    "weight_measure": weightMeasure,
    "name": name,
    "comment": comment,
    "available": available,
    "visible": visible,
    "price": price,
    "image": image,
    "store_uuid": storeUuid,
    "toppings": toppings,
    "number": number,
    "selected_variant": selectedVariant.toJson(),
  };
}

class SelectedVariant {
  SelectedVariant({
    this.uuid,
    this.name,
    this.standard,
    this.price,
    this.comment,
  });

  String uuid;
  String name;
  bool standard;
  int price;
  String comment;

  factory SelectedVariant.fromJson(Map<String, dynamic> json) => SelectedVariant(
    uuid: json["uuid"],
    name: json["name"],
    standard: json["standard"],
    price: json["price"],
    comment: json["comment"],
  );

  Map<String, dynamic> toJson() => {
    "uuid": uuid,
    "name": name,
    "standard": standard,
    "price": price,
    "comment": comment,
  };
}

class Store {
  Store({
    this.uuid,
    this.name,
    this.phone,
    this.staffPhones,
    this.comment,
    this.needToEnter,
    this.ownDelivery,
    this.image,
    this.available,
    this.visible,
    this.serialNumber,
    this.workSchedule,
    this.type,
    this.productCategory,
    this.orderPreparationTimeSecond,
    this.averageCheck,
    this.paymentTypes,
    this.categories,
    this.freeShipping,
    this.contactName,
    this.contactPhone,
    this.businessEmail,
    this.licenseBody,
    this.licenseAccepted,
    this.requisites,
    this.url,
  });

  String uuid;
  String name;
  String phone;
  List<String> staffPhones;
  String comment;
  bool needToEnter;
  bool ownDelivery;
  String image;
  bool available;
  bool visible;
  int serialNumber;
  List<WorkSchedule> workSchedule;
  String type;
  List<String> productCategory;
  int orderPreparationTimeSecond;
  int averageCheck;
  List<String> paymentTypes;
  List<String> categories;
  int freeShipping;
  String contactName;
  String contactPhone;
  String businessEmail;
  String licenseBody;
  bool licenseAccepted;
  Requisites requisites;
  String url;

  factory Store.fromJson(Map<String, dynamic> json) => Store(
    uuid: json["uuid"],
    name: json["name"],
    phone: json["phone"],
    staffPhones: List<String>.from(json["staff_phones"].map((x) => x)),
    comment: json["comment"],
    needToEnter: json["need_to_enter"],
    ownDelivery: json["own_delivery"],
    image: json["image"],
    available: json["available"],
    visible: json["visible"],
    serialNumber: json["serial_number"],
    workSchedule: List<WorkSchedule>.from(json["work_schedule"].map((x) => WorkSchedule.fromJson(x))),
    type: json["type"],
    productCategory: List<String>.from(json["product_category"].map((x) => x)),
    orderPreparationTimeSecond: json["order_preparation_time_second"],
    averageCheck: json["average_check"],
    paymentTypes: List<String>.from(json["payment_types"].map((x) => x)),
    categories: List<String>.from(json["categories"].map((x) => x)),
    freeShipping: json["free_shipping"],
    contactName: json["contact_name"],
    contactPhone: json["contact_phone"],
    businessEmail: json["business_email"],
    licenseBody: json["license_body"],
    licenseAccepted: json["license_accepted"],
    requisites: Requisites.fromJson(json["requisites"]),
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "uuid": uuid,
    "name": name,
    "phone": phone,
    "staff_phones": List<dynamic>.from(staffPhones.map((x) => x)),
    "comment": comment,
    "need_to_enter": needToEnter,
    "own_delivery": ownDelivery,
    "image": image,
    "available": available,
    "visible": visible,
    "serial_number": serialNumber,
    "work_schedule": List<dynamic>.from(workSchedule.map((x) => x.toJson())),
    "type": type,
    "product_category": List<dynamic>.from(productCategory.map((x) => x)),
    "order_preparation_time_second": orderPreparationTimeSecond,
    "average_check": averageCheck,
    "payment_types": List<dynamic>.from(paymentTypes.map((x) => x)),
    "categories": List<dynamic>.from(categories.map((x) => x)),
    "free_shipping": freeShipping,
    "contact_name": contactName,
    "contact_phone": contactPhone,
    "business_email": businessEmail,
    "license_body": licenseBody,
    "license_accepted": licenseAccepted,
    "requisites": requisites.toJson(),
    "url": url,
  };
}

class Requisites {
  Requisites({
    this.fullName,
    this.legalAddress,
    this.realAddress,
    this.inn,
    this.kpp,
    this.ogrn,
    this.bik,
    this.checkingAccount,
    this.corrAccount,
    this.bankName,
  });

  String fullName;
  String legalAddress;
  String realAddress;
  String inn;
  String kpp;
  String ogrn;
  String bik;
  String checkingAccount;
  String corrAccount;
  String bankName;

  factory Requisites.fromJson(Map<String, dynamic> json) => Requisites(
    fullName: json["full_name"],
    legalAddress: json["legal_address"],
    realAddress: json["real_address"],
    inn: json["inn"],
    kpp: json["kpp"],
    ogrn: json["ogrn"],
    bik: json["bik"],
    checkingAccount: json["checking_account"],
    corrAccount: json["corr_account"],
    bankName: json["bank_name"],
  );

  Map<String, dynamic> toJson() => {
    "full_name": fullName,
    "legal_address": legalAddress,
    "real_address": realAddress,
    "inn": inn,
    "kpp": kpp,
    "ogrn": ogrn,
    "bik": bik,
    "checking_account": checkingAccount,
    "corr_account": corrAccount,
    "bank_name": bankName,
  };
}

class WorkSchedule {
  WorkSchedule({
    this.weekDay,
    this.dayOff,
    this.workBeginning,
    this.workEnding,
  });

  int weekDay;
  bool dayOff;
  int workBeginning;
  int workEnding;

  factory WorkSchedule.fromJson(Map<String, dynamic> json) => WorkSchedule(
    weekDay: json["week_day"],
    dayOff: json["day_off"],
    workBeginning: json["work_beginning"],
    workEnding: json["work_ending"],
  );

  Map<String, dynamic> toJson() => {
    "week_day": weekDay,
    "day_off": dayOff,
    "work_beginning": workBeginning,
    "work_ending": workEnding,
  };
}

class OrdersDatumPromotion {
  OrdersDatumPromotion({
    this.isVip,
    this.isUnpaid,
  });

  bool isVip;
  bool isUnpaid;

  factory OrdersDatumPromotion.fromJson(Map<String, dynamic> json) => OrdersDatumPromotion(
    isVip: json["is_vip"],
    isUnpaid: json["is_unpaid"],
  );

  Map<String, dynamic> toJson() => {
    "is_vip": isVip,
    "is_unpaid": isUnpaid,
  };
}

class RouteWayData {
  RouteWayData({
    this.routes,
    this.routeFromDriverToClient,
    this.steps,
  });

  RouteFromDriverToClient routes;
  RouteFromDriverToClient routeFromDriverToClient;
  List<RouteFromDriverToClient> steps;

  factory RouteWayData.fromJson(Map<String, dynamic> json) => RouteWayData(
    routes: RouteFromDriverToClient.fromJson(json["routes"]),
    routeFromDriverToClient: RouteFromDriverToClient.fromJson(json["route_from_driver_to_client"]),
    steps: List<RouteFromDriverToClient>.from(json["steps"].map((x) => RouteFromDriverToClient.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "routes": routes.toJson(),
    "route_from_driver_to_client": routeFromDriverToClient.toJson(),
    "steps": List<dynamic>.from(steps.map((x) => x.toJson())),
  };
}

class RouteFromDriverToClient {
  RouteFromDriverToClient({
    this.geometry,
    this.type,
    this.properties,
  });

  Geometry geometry;
  String type;
  Properties properties;

  factory RouteFromDriverToClient.fromJson(Map<String, dynamic> json) => RouteFromDriverToClient(
    geometry: Geometry.fromJson(json["geometry"]),
    type: json["type"],
    properties: Properties.fromJson(json["properties"]),
  );

  Map<String, dynamic> toJson() => {
    "geometry": geometry.toJson(),
    "type": type,
    "properties": properties.toJson(),
  };
}

class Geometry {
  Geometry({
    this.coordinates,
    this.type,
  });

  List<List<double>> coordinates;
  String type;

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
    coordinates: json["coordinates"] == null ? null : List<List<double>>.from(json["coordinates"].map((x) => List<double>.from(x.map((x) => x.toDouble())))),
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "coordinates": coordinates == null ? null : List<dynamic>.from(coordinates.map((x) => List<dynamic>.from(x.map((x) => x)))),
    "type": type,
  };
}

class Properties {
  Properties({
    this.duration,
    this.distance,
  });

  int duration;
  double distance;

  factory Properties.fromJson(Map<String, dynamic> json) => Properties(
    duration: json["duration"],
    distance: json["distance"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "duration": duration,
    "distance": distance,
  };
}

class Service {
  Service({
    this.uuid,
    this.name,
    this.priceCoefficient,
    this.freight,
    this.productDelivery,
    this.comment,
    this.maxBonusPaymentPercent,
    this.image,
    this.imagesSet,
    this.tag,
  });

  String uuid;
  String name;
  int priceCoefficient;
  bool freight;
  bool productDelivery;
  String comment;
  int maxBonusPaymentPercent;
  String image;
  ImagesSet imagesSet;
  List<String> tag;

  factory Service.fromJson(Map<String, dynamic> json) => Service(
    uuid: json["uuid"],
    name: json["name"],
    priceCoefficient: json["price_coefficient"],
    freight: json["freight"],
    productDelivery: json["product_delivery"],
    comment: json["comment"],
    maxBonusPaymentPercent: json["max_bonus_payment_percent"],
    image: json["image"],
    imagesSet: ImagesSet.fromJson(json["images_set"]),
    tag: List<String>.from(json["tag"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "uuid": uuid,
    "name": name,
    "price_coefficient": priceCoefficient,
    "freight": freight,
    "product_delivery": productDelivery,
    "comment": comment,
    "max_bonus_payment_percent": maxBonusPaymentPercent,
    "image": image,
    "images_set": imagesSet.toJson(),
    "tag": List<dynamic>.from(tag.map((x) => x)),
  };
}

class ImagesSet {
  ImagesSet({
    this.fullFormat,
    this.smallFormat,
    this.mediumFormat,
  });

  String fullFormat;
  String smallFormat;
  String mediumFormat;

  factory ImagesSet.fromJson(Map<String, dynamic> json) => ImagesSet(
    fullFormat: json["full_format"],
    smallFormat: json["small_format"],
    mediumFormat: json["medium_format"],
  );

  Map<String, dynamic> toJson() => {
    "full_format": fullFormat,
    "small_format": smallFormat,
    "medium_format": mediumFormat,
  };
}

class OrdersDatumTariff {
  OrdersDatumTariff({
    this.name,
    this.totalPrice,
    this.fixedPrice,
    this.productsPrice,
    this.guaranteedDriverIncome,
    this.guaranteedDriverIncomeForDelivery,
    this.supplementToGuaranteedIncome,
    this.tariffCalcType,
    this.orderTripTime,
    this.orderCompleateDist,
    this.orderStartTime,
    this.minPaymentWithTime,
    this.currency,
    this.paymentType,
    this.maxBonusPayment,
    this.bonusPayment,
    this.items,
    this.waitingBoarding,
    this.waitingPoint,
    this.timeTaximeter,
    this.waitingPrice,
    this.surge,
    this.precalculated,
  });

  String name;
  int totalPrice;
  int fixedPrice;
  int productsPrice;
  int guaranteedDriverIncome;
  int guaranteedDriverIncomeForDelivery;
  int supplementToGuaranteedIncome;
  String tariffCalcType;
  int orderTripTime;
  int orderCompleateDist;
  int orderStartTime;
  int minPaymentWithTime;
  String currency;
  String paymentType;
  int maxBonusPayment;
  int bonusPayment;
  List<Item> items;
  Map<String, int> waitingBoarding;
  Map<String, int> waitingPoint;
  Map<String, int> timeTaximeter;
  int waitingPrice;
  dynamic surge;
  String precalculated;

  factory OrdersDatumTariff.fromJson(Map<String, dynamic> json) => OrdersDatumTariff(
    name: json["name"],
    totalPrice: json["total_price"],
    fixedPrice: json["fixed_price"],
    productsPrice: json["products_price"],
    guaranteedDriverIncome: json["guaranteed_driver_income"],
    guaranteedDriverIncomeForDelivery: json["guaranteed_driver_income_for_delivery"],
    supplementToGuaranteedIncome: json["supplement_to_guaranteed_income"],
    tariffCalcType: json["tariff_calc_type"],
    orderTripTime: json["order_trip_time"],
    orderCompleateDist: json["order_compleate_dist"],
    orderStartTime: json["order_start_time"],
    minPaymentWithTime: json["min_payment_with_time"],
    currency: json["currency"],
    paymentType: json["payment_type"],
    maxBonusPayment: json["max_bonus_payment"],
    bonusPayment: json["bonus_payment"],
    items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
    waitingBoarding: Map.from(json["waiting_boarding"]).map((k, v) => MapEntry<String, int>(k, v)),
    waitingPoint: Map.from(json["waiting_point"]).map((k, v) => MapEntry<String, int>(k, v)),
    timeTaximeter: Map.from(json["time_taximeter"]).map((k, v) => MapEntry<String, int>(k, v)),
    waitingPrice: json["waiting_price"],
    surge: json["surge"],
    precalculated: json["precalculated"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "total_price": totalPrice,
    "fixed_price": fixedPrice,
    "products_price": productsPrice,
    "guaranteed_driver_income": guaranteedDriverIncome,
    "guaranteed_driver_income_for_delivery": guaranteedDriverIncomeForDelivery,
    "supplement_to_guaranteed_income": supplementToGuaranteedIncome,
    "tariff_calc_type": tariffCalcType,
    "order_trip_time": orderTripTime,
    "order_compleate_dist": orderCompleateDist,
    "order_start_time": orderStartTime,
    "min_payment_with_time": minPaymentWithTime,
    "currency": currency,
    "payment_type": paymentType,
    "max_bonus_payment": maxBonusPayment,
    "bonus_payment": bonusPayment,
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
    "waiting_boarding": Map.from(waitingBoarding).map((k, v) => MapEntry<String, dynamic>(k, v)),
    "waiting_point": Map.from(waitingPoint).map((k, v) => MapEntry<String, dynamic>(k, v)),
    "time_taximeter": Map.from(timeTaximeter).map((k, v) => MapEntry<String, dynamic>(k, v)),
    "waiting_price": waitingPrice,
    "surge": surge,
    "precalculated": precalculated,
  };
}

class Item {
  Item({
    this.name,
    this.price,
  });

  String name;
  int price;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    name: json["name"],
    price: json["price"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "price": price,
  };
}
