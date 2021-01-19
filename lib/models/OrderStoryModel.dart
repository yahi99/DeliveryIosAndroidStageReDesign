import 'package:flutter_app/PostData/chat.dart';
import 'package:flutter_app/models/ChatHistoryModel.dart';
import 'ResponseData.dart';
import 'RestaurantDataItems.dart';

class OrdersStoryModel{
  List<OrdersStoryModelItem> ordersStoryModelItems;

  OrdersStoryModel( {
    this.ordersStoryModelItems,
  });

  factory OrdersStoryModel.fromJson(List<dynamic> parsedJson){

    return OrdersStoryModel(
      ordersStoryModelItems:
        List<OrdersStoryModelItem>.from(parsedJson.map((x) => OrdersStoryModelItem.fromJson(x))),
    );
  }
}

class OrdersStoryModelItem {
  OrdersStoryModelItem({
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
    this.counterOrderMarker,
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
  OrdersStoryModelItemTariff tariff;
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
  OrdersStoryModelItemPromotion promotion;
  int arrivalTime;
  ProductsData productsData;
  String paymentType;
  PaymentMeta paymentMeta;
  DateTime estimatedDeliveryTime;
  bool counterOrderMarker;
  TaxiParkData taxiParkData;
  String taxiParkUuid;
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

    factory OrdersStoryModelItem.fromJson(Map<String, dynamic> json) {

      // Костыль, заполняющий ресторан его адресами (одним)
      ProductsData pd;
      if(json["products_data"] != null){
        pd = ProductsData.fromJson(json["products_data"]);

        List<DestinationPoints> routesList = new List<DestinationPoints>();
        var routes_list = json['routes'] as List;
        if(routes_list != null){
          routesList = routes_list.map((i) =>
              DestinationPoints.fromJson(i)).toList();
        }

        pd.store.destination_points = routesList;

        if(routesList.length > 1){
          routesList.removeAt(1);
        }
      }



      return OrdersStoryModelItem(
      uuid: json["uuid"],
      comment: json["comment"] == null ? null : json["comment"],
      routes: (json["routes"] == null) ? null : List<DestinationPoints>.from(json["routes"].map((x) => DestinationPoints.fromJson(x))),
      routeWayData: RouteWayData.fromJson(json["route_way_data"]),
      features: json["features"],
      tariff: OrdersStoryModelItemTariff.fromJson(json["tariff"]),
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
      promotion: OrdersStoryModelItemPromotion.fromJson(json["promotion"]),
      arrivalTime: json["arrival_time"],
      productsData: pd,
      paymentType: json["payment_type"],
      paymentMeta: PaymentMeta.fromJson(json["payment_meta"]),
      estimatedDeliveryTime: DateTime.parse(json["estimated_delivery_time"]),
      counterOrderMarker: json["counter_order_marker"],
      taxiParkData: TaxiParkData.fromJson(json["taxi_park_data"]),
      taxiParkUuid: json["taxi_park_uuid"] == null ? null : json["taxi_park_uuid"],
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
  }

  Future<bool> hasNewMessage() async{
    bool result = false;
    ChatHistoryModel chatHistory = await Chat.loadChatHistory(uuid, 'driver');
    chatHistory.chatMessageList.forEach((message) {
      if(message.to == 'client' && !message.ack){
        result = true;
        return;
      }
    });
    return result;
  }
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
  });

  bool enable;
  String referralCode;
  String parentUuid;
  String referralParentCode;
  String referralParentPhone;
  int activationCount;
  int recipientsTravelCount;

  factory ReferralProgramData.fromJson(Map<String, dynamic> json) => ReferralProgramData(
    enable: json["enable"],
    referralCode: json["referral_code"],
    parentUuid: json["parent_uuid"],
    referralParentCode: json["referral_parent_code"],
    referralParentPhone: json["referral_parent_phone"],
    activationCount: json["activation_count"],
    recipientsTravelCount: json["recipients_travel_count"],
  );

  Map<String, dynamic> toJson() => {
    "enable": enable,
    "referral_code": referralCode,
    "parent_uuid": parentUuid,
    "referral_parent_code": referralParentCode,
    "referral_parent_phone": referralParentPhone,
    "activation_count": activationCount,
    "recipients_travel_count": recipientsTravelCount,
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
    this.maxServiceLevel,
  });

  String uuid;
  String name;
  List<String> paymentTypes;
  String phone;
  String comment;
  String stateName;
  String car;
  int balance;
  int cardBalance;
  double karma;
  String color;
  DriverTariff tariff;
  List<String> tag;
  List<Service> availableServices;
  List<AvailableFeature> availableFeatures;
  int alias;
  String regNumber;
  int activity;
  DriverPromotion promotion;
  Group group;
  dynamic blacklist;
  Meta meta;
  bool counterOrderSwitch;
  TaxiParkData taxiParkData;
  String taxiParkUuid;
  int maxServiceLevel;

  factory Driver.fromJson(Map<String, dynamic> json) => Driver(
    uuid: json["uuid"],
    name: json["name"],
    paymentTypes: json["payment_types"] == null ? null : List<String>.from(json["payment_types"].map((x) => x)),
    phone: json["phone"],
    comment: json["comment"],
    stateName: json["state_name"],
    car: json["car"],
    balance: json["balance"],
    cardBalance: json["card_balance"],
    karma: json["karma"] * 1.0,
    color: json["color"],
    tariff: DriverTariff.fromJson(json["tariff"]),
    tag: json["tag"] == null ? null : List<String>.from(json["tag"].map((x) => x)),
    availableServices: json["available_services"] == null ? null : List<Service>.from(json["available_services"].map((x) => Service.fromJson(x))),
    availableFeatures: json["available_features"] == null ? null : List<AvailableFeature>.from(json["available_features"].map((x) => AvailableFeature.fromJson(x))),
    alias: json["alias"],
    regNumber: json["reg_number"],
    activity: json["activity"],
    promotion: DriverPromotion.fromJson(json["promotion"]),
    group: Group.fromJson(json["group"]),
    blacklist: json["blacklist"],
    meta: Meta.fromJson(json["meta"]),
    counterOrderSwitch: json["counter_order_switch"] == null ? null : json["counter_order_switch"],
    taxiParkData: TaxiParkData.fromJson(json["taxi_park_data"]),
    taxiParkUuid: json["taxi_park_uuid"] == null ? null : json["taxi_park_uuid"],
    maxServiceLevel: json["max_service_level"] == null ? null : json["max_service_level"],
  );

  Map<String, dynamic> toJson() => {
    "uuid": uuid,
    "name": name,
    "payment_types": paymentTypes == null ? null : List<dynamic>.from(paymentTypes.map((x) => x)),
    "phone": phone,
    "comment": comment,
    "state_name": stateName,
    "car": car,
    "balance": balance,
    "card_balance": cardBalance,
    "karma": karma,
    "color": color,
    "tariff": tariff.toJson(),
    "tag": tag == null ? null : List<dynamic>.from(tag.map((x) => x)),
    "available_services": availableServices == null ? null : List<dynamic>.from(availableServices.map((x) => x.toJson())),
    "available_features": availableFeatures == null ? null : List<dynamic>.from(availableFeatures.map((x) => x.toJson())),
    "alias": alias,
    "reg_number": regNumber,
    "activity": activity,
    "promotion": promotion.toJson(),
    "group": group.toJson(),
    "blacklist": blacklist,
    "meta": meta.toJson(),
    "counter_order_switch": counterOrderSwitch == null ? null : counterOrderSwitch,
    "taxi_park_data": taxiParkData.toJson(),
    "taxi_park_uuid": taxiParkUuid == null ? null : taxiParkUuid,
    "max_service_level": maxServiceLevel == null ? null : maxServiceLevel,
  };
}

class AvailableFeature {
  AvailableFeature({
    this.uuid,
    this.name,
    this.comment,
    this.price,
    this.tag,
    this.servicesUuid,
  });

  String uuid;
  String name;
  String comment;
  int price;
  List<String> tag;
  List<String> servicesUuid;

  factory AvailableFeature.fromJson(Map<String, dynamic> json) => AvailableFeature(
    uuid: json["uuid"],
    name: json["name"],
    comment: json["comment"],
    price: json["price"],
    tag: List<String>.from(json["tag"].map((x) => x)),
    servicesUuid: List<String>.from(json["services_uuid"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "uuid": uuid,
    "name": name,
    "comment": comment,
    "price": price,
    "tag": List<dynamic>.from(tag.map((x) => x)),
    "services_uuid": List<dynamic>.from(servicesUuid.map((x) => x)),
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
  double priceCoefficient;
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
    priceCoefficient: json["price_coefficient"].toDouble(),
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
    fullFormat: json["full_format"] == null ? null : json["full_format"],
    smallFormat: json["small_format"] == null ? null : json["small_format"],
    mediumFormat: json["medium_format"] == null ? null : json["medium_format"],
  );

  Map<String, dynamic> toJson() => {
    "full_format": fullFormat == null ? null : fullFormat,
    "small_format": smallFormat == null ? null : smallFormat,
    "medium_format": mediumFormat == null ? null : mediumFormat,
  };
}

class Group {
  Group({
    this.uuid,
    this.name,
    this.description,
    this.distributionWeight,
    this.servicesUuid,
    this.tag,
    this.defaultTariffUuid,
    this.defaultTariffOfflineUuid,
  });

  String uuid;
  String name;
  String description;
  int distributionWeight;
  List<String> servicesUuid;
  List<String> tag;
  String defaultTariffUuid;
  String defaultTariffOfflineUuid;

  factory Group.fromJson(Map<String, dynamic> json) => Group(
    uuid: json["uuid"],
    name: json["name"],
    description: json["description"],
    distributionWeight: json["distribution_weight"],
    servicesUuid: json["services_uuid"] == null ? null : List<String>.from(json["services_uuid"].map((x) => x)),
    tag: json["tag"] == null ? null : List<String>.from(json["tag"].map((x) => x)),
    defaultTariffUuid: json["default_tariff_uuid"],
    defaultTariffOfflineUuid: json["default_tariff_offline_uuid"],
  );

  Map<String, dynamic> toJson() => {
    "uuid": uuid,
    "name": name,
    "description": description,
    "distribution_weight": distributionWeight,
    "services_uuid": servicesUuid == null ? null : List<dynamic>.from(servicesUuid.map((x) => x)),
    "tag": tag == null ? null : List<dynamic>.from(tag.map((x) => x)),
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
  List<String> driversGroupsUuid;
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
    driversGroupsUuid: json["drivers_groups_uuid"] == null ? null : List<String>.from(json["drivers_groups_uuid"].map((x) => x)),
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
    "drivers_groups_uuid": driversGroupsUuid == null ? null : List<dynamic>.from(driversGroupsUuid.map((x) => x)),
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

  Records store;
  int preparationTime;
  int confirmationTime;
  bool buyout;
  String orderNumberInStore;
  List<Product> products;



  factory ProductsData.fromJson(Map<String, dynamic> json){


    return ProductsData(
      store: (json['store'] == null) ? null : Records.fromJson(json['store']),
      preparationTime: json["preparation_time"],
      confirmationTime: json["confirmation_time"],
      buyout: json["buyout"],
      orderNumberInStore: json["order_number_in_store"],
      products: List<Product>.from(
          json["products"].map((x) => Product.fromJson(x))),

    );
   }
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
  List<Toppings> toppings;
  int number;
  Variants selectedVariant;

  factory Product.fromJson(Map<String, dynamic> json){

    var toppings_list = json['toppings'] as List;
    List<Toppings> toppingsList = null;
    if(toppings_list != null){
      toppingsList = toppings_list.map((i) =>
          Toppings.fromJson(i)).toList();
    }

    return Product(
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
      toppings: toppingsList,
      number: json["number"],
      selectedVariant: Variants.fromJson(json['selected_variant']),
    );
  }
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

class OrdersStoryModelItemPromotion {
  OrdersStoryModelItemPromotion({
    this.isVip,
    this.isUnpaid,
  });

  bool isVip;
  bool isUnpaid;

  factory OrdersStoryModelItemPromotion.fromJson(Map<String, dynamic> json) => OrdersStoryModelItemPromotion(
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
    steps: json["steps"] == null ? null : List<RouteFromDriverToClient>.from(json["steps"].map((x) => RouteFromDriverToClient.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "routes": routes.toJson(),
    "route_from_driver_to_client": routeFromDriverToClient.toJson(),
    "steps": steps == null ? null : List<dynamic>.from(steps.map((x) => x.toJson())),
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

class OrdersStoryModelItemTariff {
  OrdersStoryModelItemTariff({
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

  factory OrdersStoryModelItemTariff.fromJson(Map<String, dynamic> json) => OrdersStoryModelItemTariff(
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
    waitingBoarding: json["waiting_boarding"] == null ? null : Map.from(json["waiting_boarding"]).map((k, v) => MapEntry<String, int>(k, v)),
    waitingPoint: json["waiting_point"] == null ? null : Map.from(json["waiting_point"]).map((k, v) => MapEntry<String, int>(k, v)),
    timeTaximeter: json["time_taximeter"] == null ? null : Map.from(json["time_taximeter"]).map((k, v) => MapEntry<String, int>(k, v)),
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
    "waiting_boarding": waitingBoarding == null ? null : Map.from(waitingBoarding).map((k, v) => MapEntry<String, dynamic>(k, v)),
    "waiting_point": waitingPoint == null ? null : Map.from(waitingPoint).map((k, v) => MapEntry<String, dynamic>(k, v)),
    "time_taximeter": timeTaximeter == null ? null : Map.from(timeTaximeter).map((k, v) => MapEntry<String, dynamic>(k, v)),
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
