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


//String ordersStoryModelItemToJson(List<OrdersStoryModelItem> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

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
  OrdersStoryModelItemPaymentType paymentType;
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
      paymentType: ordersStoryModelItemPaymentTypeValues.map[json["payment_type"]],
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

  // Map<String, dynamic> toJson() => {
  //   "uuid": uuid,
  //   "comment": comment == null ? null : comment,
  //   "routes": List<dynamic>.from(routes.map((x) => x.toJson())),
  //   "route_way_data": routeWayData.toJson(),
  //   "features": features,
  //   "tariff": tariff.toJson(),
  //   "phone_line": phoneLine.toJson(),
  //   "fixed_price": fixedPrice,
  //   "service": service.toJson(),
  //   "increased_fare": increasedFare,
  //   "driver": driver.toJson(),
  //   "client": client.toJson(),
  //   "source": sourceValues.reverse[source],
  //   "driver_rating": driverRating.toJson(),
  //   "client_rating": clientRating.toJson(),
  //   "is_optional": isOptional,
  //   "without_delivery": withoutDelivery,
  //   "own_delivery": ownDelivery,
  //   "order_start": orderStart.toIso8601String(),
  //   "cancel_time": cancelTime.toIso8601String(),
  //   "distribution_by_taxi_park": distributionByTaxiPark,
  //   "promotion": promotion.toJson(),
  //   "arrival_time": arrivalTime,
  //   "products_data": productsData == null ? null : productsData.toJson(),
  //   "payment_type": ordersStoryModelItemPaymentTypeValues.reverse[paymentType],
  //   "payment_meta": paymentMeta.toJson(),
  //   "estimated_delivery_time": estimatedDeliveryTime.toIso8601String(),
  //   "counter_order_marker": counterOrderMarker,
  //   "taxi_park_data": taxiParkData.toJson(),
  //   "taxi_park_uuid": taxiParkUuid == null ? null : taxiParkUuid,
  //   "id": id,
  //   "client_uuid": clientUuid,
  //   "service_uuid": serviceUuid,
  //   "callback_phone": phoneValues.reverse[callbackPhone],
  //   "features_uuids": featuresUuids,
  //   "created_at": createdAt.toIso8601String(),
  //   "created_at_unix": createdAtUnix,
  //   "updated_at": updatedAt.toIso8601String(),
  //   "visibility": visibility,
  //   "state": stateValues.reverse[state],
  //   "state_title": stateTitleValues.reverse[stateTitle],
  // };

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
  DriverName name;
  List<PaymentTypeElement> paymentTypes;
  String phone;
  String comment;
  StateName stateName;
  String car;
  int balance;
  int cardBalance;
  int karma;
  String color;
  DriverTariff tariff;
  List<Tag> tag;
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
    name: driverNameValues.map[json["name"]],
    paymentTypes: json["payment_types"] == null ? null : List<PaymentTypeElement>.from(json["payment_types"].map((x) => paymentTypeElementValues.map[x])),
    phone: json["phone"],
    comment: json["comment"],
    stateName: stateNameValues.map[json["state_name"]],
    car: json["car"],
    balance: json["balance"],
    cardBalance: json["card_balance"],
    karma: json["karma"],
    color: json["color"],
    tariff: DriverTariff.fromJson(json["tariff"]),
    tag: json["tag"] == null ? null : List<Tag>.from(json["tag"].map((x) => tagValues.map[x])),
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
    "name": driverNameValues.reverse[name],
    "payment_types": paymentTypes == null ? null : List<dynamic>.from(paymentTypes.map((x) => paymentTypeElementValues.reverse[x])),
    "phone": phone,
    "comment": comment,
    "state_name": stateNameValues.reverse[stateName],
    "car": car,
    "balance": balance,
    "card_balance": cardBalance,
    "karma": karma,
    "color": color,
    "tariff": tariff.toJson(),
    "tag": tag == null ? null : List<dynamic>.from(tag.map((x) => tagValues.reverse[x])),
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
  AvailableFeatureName name;
  AvailableFeatureComment comment;
  int price;
  List<Tag> tag;
  List<String> servicesUuid;

  factory AvailableFeature.fromJson(Map<String, dynamic> json) => AvailableFeature(
    uuid: json["uuid"],
    name: availableFeatureNameValues.map[json["name"]],
    comment: availableFeatureCommentValues.map[json["comment"]],
    price: json["price"],
    tag: List<Tag>.from(json["tag"].map((x) => tagValues.map[x])),
    servicesUuid: List<String>.from(json["services_uuid"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "uuid": uuid,
    "name": availableFeatureNameValues.reverse[name],
    "comment": availableFeatureCommentValues.reverse[comment],
    "price": price,
    "tag": List<dynamic>.from(tag.map((x) => tagValues.reverse[x])),
    "services_uuid": List<dynamic>.from(servicesUuid.map((x) => x)),
  };
}

enum AvailableFeatureComment { EFVE, EMPTY, COMMENT_FOR_FEATURE_966, COMMENT_FOR_FEATURE_631 }

final availableFeatureCommentValues = EnumValues({
  "comment for feature #631": AvailableFeatureComment.COMMENT_FOR_FEATURE_631,
  "comment for feature #966": AvailableFeatureComment.COMMENT_FOR_FEATURE_966,
  "efve": AvailableFeatureComment.EFVE,
  "": AvailableFeatureComment.EMPTY
});

enum AvailableFeatureName { EMPTY, NAME, PURPLE, FLUFFY, TENTACLED }

final availableFeatureNameValues = EnumValues({
  "Детское кресло": AvailableFeatureName.EMPTY,
  "Пустой багажник": AvailableFeatureName.FLUFFY,
  "До двери": AvailableFeatureName.NAME,
  "Некурящий": AvailableFeatureName.PURPLE,
  "Перевозка животных": AvailableFeatureName.TENTACLED
});

enum Tag { BABY_CHAIR, DOOR_TO_DOOR, NON_SMOKER, EMPTY_TRUNK, TRANSPORTATION_OF_ANIMALS, DELIVERY, COMFORT, STANDART, DEBUG }

final tagValues = EnumValues({
  "baby_chair": Tag.BABY_CHAIR,
  "comfort": Tag.COMFORT,
  "debug": Tag.DEBUG,
  "delivery": Tag.DELIVERY,
  "door_to_door": Tag.DOOR_TO_DOOR,
  "empty_trunk": Tag.EMPTY_TRUNK,
  "non_smoker": Tag.NON_SMOKER,
  "standart": Tag.STANDART,
  "transportation_of_animals": Tag.TRANSPORTATION_OF_ANIMALS
});

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
  ServiceComment comment;
  int maxBonusPaymentPercent;
  String image;
  ImagesSet imagesSet;
  List<Tag> tag;

  factory Service.fromJson(Map<String, dynamic> json) => Service(
    uuid: json["uuid"],
    name: json["name"],
    priceCoefficient: json["price_coefficient"].toDouble(),
    freight: json["freight"],
    productDelivery: json["product_delivery"],
    comment: serviceCommentValues.map[json["comment"]],
    maxBonusPaymentPercent: json["max_bonus_payment_percent"],
    image: json["image"],
    imagesSet: ImagesSet.fromJson(json["images_set"]),
    tag: List<Tag>.from(json["tag"].map((x) => tagValues.map[x])),
  );

  Map<String, dynamic> toJson() => {
    "uuid": uuid,
    "name": name,
    "price_coefficient": priceCoefficient,
    "freight": freight,
    "product_delivery": productDelivery,
    "comment": serviceCommentValues.reverse[comment],
    "max_bonus_payment_percent": maxBonusPaymentPercent,
    "image": image,
    "images_set": imagesSet.toJson(),
    "tag": List<dynamic>.from(tag.map((x) => tagValues.reverse[x])),
  };
}

enum ServiceComment { EMPTY, MM, COMMENT, PURPLE }

final serviceCommentValues = EnumValues({
  "золотая середина, для прагматичных": ServiceComment.COMMENT,
  "Доставка легковых грузов": ServiceComment.EMPTY,
  "для тех кто привык к комфортуmm.": ServiceComment.MM,
  "дебаж меня полностью": ServiceComment.PURPLE
});

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
  GroupName name;
  Description description;
  int distributionWeight;
  List<String> servicesUuid;
  List<String> tag;
  String defaultTariffUuid;
  String defaultTariffOfflineUuid;

  factory Group.fromJson(Map<String, dynamic> json) => Group(
    uuid: json["uuid"],
    name: groupNameValues.map[json["name"]],
    description: descriptionValues.map[json["description"]],
    distributionWeight: json["distribution_weight"],
    servicesUuid: json["services_uuid"] == null ? null : List<String>.from(json["services_uuid"].map((x) => x)),
    tag: json["tag"] == null ? null : List<String>.from(json["tag"].map((x) => x)),
    defaultTariffUuid: json["default_tariff_uuid"],
    defaultTariffOfflineUuid: json["default_tariff_offline_uuid"],
  );

  Map<String, dynamic> toJson() => {
    "uuid": uuid,
    "name": groupNameValues.reverse[name],
    "description": descriptionValues.reverse[description],
    "distribution_weight": distributionWeight,
    "services_uuid": servicesUuid == null ? null : List<dynamic>.from(servicesUuid.map((x) => x)),
    "tag": tag == null ? null : List<dynamic>.from(tag.map((x) => x)),
    "default_tariff_uuid": defaultTariffUuid,
    "default_tariff_offline_uuid": defaultTariffOfflineUuid,
  };
}

enum Description { DEFAUL_DRIVER_GROUP, EMPTY }

final descriptionValues = EnumValues({
  "defaul_driver_group": Description.DEFAUL_DRIVER_GROUP,
  "": Description.EMPTY
});

enum GroupName { EMPTY, NAME, THE_3, THE_15 }

final groupNameValues = EnumValues({
  "Стандарт": GroupName.EMPTY,
  "": GroupName.NAME,
  "Базовый 15%": GroupName.THE_15,
  "3%": GroupName.THE_3
});

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

enum DriverName { EMPTY, NAME, PURPLE, FLUFFY }

final driverNameValues = EnumValues({
  "Алек Воробьев": DriverName.EMPTY,
  "Раф": DriverName.FLUFFY,
  "": DriverName.NAME,
  "Тестовый": DriverName.PURPLE
});

enum PaymentTypeElement { CASH, CARD, ONLINE_TRANSFER }

final paymentTypeElementValues = EnumValues({
  "card": PaymentTypeElement.CARD,
  "cash": PaymentTypeElement.CASH,
  "online_transfer": PaymentTypeElement.ONLINE_TRANSFER
});

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

enum StateName { CONSIDERING, EMPTY, WORKING, OFFLINE }

final stateNameValues = EnumValues({
  "considering": StateName.CONSIDERING,
  "": StateName.EMPTY,
  "offline": StateName.OFFLINE,
  "working": StateName.WORKING
});

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
  TariffType tariffType;
  GroupName name;
  TariffComment comment;
  TariffColor color;
  RejExp rejExp;
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
    tariffType: tariffTypeValues.map[json["tariff_type"]],
    name: groupNameValues.map[json["name"]],
    comment: tariffCommentValues.map[json["comment"]],
    color: tariffColorValues.map[json["color"]],
    rejExp: rejExpValues.map[json["rej_exp"]],
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
    "tariff_type": tariffTypeValues.reverse[tariffType],
    "name": groupNameValues.reverse[name],
    "comment": tariffCommentValues.reverse[comment],
    "color": tariffColorValues.reverse[color],
    "rej_exp": rejExpValues.reverse[rejExp],
    "comm_exp": commExp,
    "period": period,
    "period_price": periodPrice,
    "payed_at": payedAt,
  };
}

enum TariffColor { THE_2_FBF52, EMPTY, THE_9802_AF }

final tariffColorValues = EnumValues({
  "": TariffColor.EMPTY,
  "#2FBF52": TariffColor.THE_2_FBF52,
  "#9802AF": TariffColor.THE_9802_AF
});

enum TariffComment { EMPTY, COMMENT }

final tariffCommentValues = EnumValues({
  "": TariffComment.COMMENT,
  "Стандартный тариф": TariffComment.EMPTY
});

enum RejExp { DRIVER_BALANCE_ORDER_PRICE_003, EMPTY, DRIVER_BALANCE_2, DRIVER_BALANCE_5 }

final rejExpValues = EnumValues({
  "DriverBalance-2": RejExp.DRIVER_BALANCE_2,
  "DriverBalance-5": RejExp.DRIVER_BALANCE_5,
  "DriverBalance - OrderPrice*0.03": RejExp.DRIVER_BALANCE_ORDER_PRICE_003,
  "": RejExp.EMPTY
});

enum TariffType { PERCENT, EMPTY }

final tariffTypeValues = EnumValues({
  "": TariffType.EMPTY,
  "percent": TariffType.PERCENT
});

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

enum OrdersStoryModelItemPaymentType { CASH, EMPTY, CARD }

final ordersStoryModelItemPaymentTypeValues = EnumValues({
  "card": OrdersStoryModelItemPaymentType.CARD,
  "cash": OrdersStoryModelItemPaymentType.CASH,
  "": OrdersStoryModelItemPaymentType.EMPTY
});

class PhoneLine {
  PhoneLine({
    this.uuid,
    this.serviceUuid,
    this.name,
    this.comment,
  });

  String uuid;
  String serviceUuid;
  PhoneLineName name;
  PhoneLineComment comment;

  factory PhoneLine.fromJson(Map<String, dynamic> json) => PhoneLine(
    uuid: json["uuid"],
    serviceUuid: json["service_uuid"],
    name: phoneLineNameValues.map[json["name"]],
    comment: phoneLineCommentValues.map[json["comment"]],
  );

  Map<String, dynamic> toJson() => {
    "uuid": uuid,
    "service_uuid": serviceUuid,
    "name": phoneLineNameValues.reverse[name],
    "comment": phoneLineCommentValues.reverse[comment],
  };
}

enum PhoneLineComment { REER, EMPTY }

final phoneLineCommentValues = EnumValues({
  "": PhoneLineComment.EMPTY,
  "reer": PhoneLineComment.REER
});

enum PhoneLineName { THE_78672333333, EMPTY }

final phoneLineNameValues = EnumValues({
  "": PhoneLineName.EMPTY,
  "78672333333": PhoneLineName.THE_78672333333
});

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
      store: Records.fromJson(json['store']),
      preparationTime: json["preparation_time"],
      confirmationTime: json["confirmation_time"],
      buyout: json["buyout"],
      orderNumberInStore: json["order_number_in_store"],
      products: List<Product>.from(
          json["products"].map((x) => Product.fromJson(x))),

    );
   }

  // Map<String, dynamic> toJson() => {
  //   "store": store.toJson(),
  //   "preparation_time": preparationTime,
  //   "confirmation_time": confirmationTime,
  //   "buyout": buyout,
  //   "order_number_in_store": orderNumberInStore,
  //   "products": List<dynamic>.from(products.map((x) => x.toJson())),
  // };
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

  // Map<String, dynamic> toJson() => {
  //   "uuid": uuid,
  //   "weight": weight,
  //   "weight_measure": weightMeasure,
  //   "name": name,
  //   "comment": comment,
  //   "available": available,
  //   "visible": visible,
  //   "price": price,
  //   "image": image,
  //   "store_uuid": storeUuid,
  //   "toppings": toppings,
  //   "number": number,
  //   "selected_variant": selectedVariant,
  // };
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
  RouteFromDriverToClientType type;
  Properties properties;

  factory RouteFromDriverToClient.fromJson(Map<String, dynamic> json) => RouteFromDriverToClient(
    geometry: Geometry.fromJson(json["geometry"]),
    type: routeFromDriverToClientTypeValues.map[json["type"]],
    properties: Properties.fromJson(json["properties"]),
  );

  Map<String, dynamic> toJson() => {
    "geometry": geometry.toJson(),
    "type": routeFromDriverToClientTypeValues.reverse[type],
    "properties": properties.toJson(),
  };
}

class Geometry {
  Geometry({
    this.coordinates,
    this.type,
  });

  List<List<double>> coordinates;
  GeometryType type;

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
    coordinates: json["coordinates"] == null ? null : List<List<double>>.from(json["coordinates"].map((x) => List<double>.from(x.map((x) => x.toDouble())))),
    type: geometryTypeValues.map[json["type"]],
  );

  Map<String, dynamic> toJson() => {
    "coordinates": coordinates == null ? null : List<dynamic>.from(coordinates.map((x) => List<dynamic>.from(x.map((x) => x)))),
    "type": geometryTypeValues.reverse[type],
  };
}

enum GeometryType { LINE_STRING, EMPTY }

final geometryTypeValues = EnumValues({
  "": GeometryType.EMPTY,
  "LineString": GeometryType.LINE_STRING
});

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

enum RouteFromDriverToClientType { FEATURE, EMPTY }

final routeFromDriverToClientTypeValues = EnumValues({
  "": RouteFromDriverToClientType.EMPTY,
  "Feature": RouteFromDriverToClientType.FEATURE
});


enum City { EMPTY }

final cityValues = EnumValues({
  "Владикавказ": City.EMPTY
});

enum PointType { ADDRESS, EMPTY, PUBLIC_PLACE }

final pointTypeValues = EnumValues({
  "address": PointType.ADDRESS,
  "": PointType.EMPTY,
  "public_place": PointType.PUBLIC_PLACE
});

enum Street { EMPTY, STREET, PURPLE, FLUFFY, TENTACLED }

final streetValues = EnumValues({
  "Хаджи Мамсурова": Street.EMPTY,
  "Леваневского": Street.FLUFFY,
  "Ватутина": Street.PURPLE,
  "Максима Горького": Street.STREET,
  "Владикавказская": Street.TENTACLED
});

enum RouteType { EMPTY, TYPE }

final routeTypeValues = EnumValues({
  "": RouteType.EMPTY,
  "Общественное место": RouteType.TYPE
});

enum Value { THE_46, THE_124, EMPTY, VALUE, PURPLE }

final valueValues = EnumValues({
  "СОГУ - Северо-Осетинский Государственный университет": Value.EMPTY,
  "Хиба": Value.PURPLE,
  "Максима Горького 124": Value.THE_124,
  "Хаджи Мамсурова 46": Value.THE_46,
  "Олд скул бургер": Value.VALUE
});

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

  PurpleName name;
  int totalPrice;
  int fixedPrice;
  int productsPrice;
  int guaranteedDriverIncome;
  int guaranteedDriverIncomeForDelivery;
  int supplementToGuaranteedIncome;
  TariffCalcType tariffCalcType;
  int orderTripTime;
  int orderCompleateDist;
  int orderStartTime;
  int minPaymentWithTime;
  Currency currency;
  TariffPaymentType paymentType;
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
    name: purpleNameValues.map[json["name"]],
    totalPrice: json["total_price"],
    fixedPrice: json["fixed_price"],
    productsPrice: json["products_price"],
    guaranteedDriverIncome: json["guaranteed_driver_income"],
    guaranteedDriverIncomeForDelivery: json["guaranteed_driver_income_for_delivery"],
    supplementToGuaranteedIncome: json["supplement_to_guaranteed_income"],
    tariffCalcType: tariffCalcTypeValues.map[json["tariff_calc_type"]],
    orderTripTime: json["order_trip_time"],
    orderCompleateDist: json["order_compleate_dist"],
    orderStartTime: json["order_start_time"],
    minPaymentWithTime: json["min_payment_with_time"],
    currency: currencyValues.map[json["currency"]],
    paymentType: tariffPaymentTypeValues.map[json["payment_type"]],
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
    "name": purpleNameValues.reverse[name],
    "total_price": totalPrice,
    "fixed_price": fixedPrice,
    "products_price": productsPrice,
    "guaranteed_driver_income": guaranteedDriverIncome,
    "guaranteed_driver_income_for_delivery": guaranteedDriverIncomeForDelivery,
    "supplement_to_guaranteed_income": supplementToGuaranteedIncome,
    "tariff_calc_type": tariffCalcTypeValues.reverse[tariffCalcType],
    "order_trip_time": orderTripTime,
    "order_compleate_dist": orderCompleateDist,
    "order_start_time": orderStartTime,
    "min_payment_with_time": minPaymentWithTime,
    "currency": currencyValues.reverse[currency],
    "payment_type": tariffPaymentTypeValues.reverse[paymentType],
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

enum Currency { EMPTY, CURRENCY }

final currencyValues = EnumValues({
  "": Currency.CURRENCY,
  "руб": Currency.EMPTY
});

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

enum PurpleName { EMPTY, NAME }

final purpleNameValues = EnumValues({
  "Доставка (МП)": PurpleName.EMPTY,
  "": PurpleName.NAME
});

enum TariffPaymentType { EMPTY, PAYMENT_TYPE, PURPLE }

final tariffPaymentTypeValues = EnumValues({
  "Наличные": TariffPaymentType.EMPTY,
  "": TariffPaymentType.PAYMENT_TYPE,
  "Картой": TariffPaymentType.PURPLE
});

enum TariffCalcType { WITHDIST, EMPTY }

final tariffCalcTypeValues = EnumValues({
  "": TariffCalcType.EMPTY,
  "withdist": TariffCalcType.WITHDIST
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
