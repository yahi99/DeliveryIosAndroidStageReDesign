import 'dart:convert';

InitData initDataFromJson(String str) => InitData.fromJson(json.decode(str));

String initDataToJson(InitData data) => json.encode(data.toJson());

class InitData {
  InitData({
    this.clientUuid,
    this.ordersData,
  });

  final String clientUuid;
  final List<OrdersDatum> ordersData;

  factory InitData.fromJson(Map<String, dynamic> json) => InitData(
    clientUuid: json["client_uuid"] == null ? null : json["client_uuid"],
    ordersData: json["orders_data"] == null ? null : List<OrdersDatum>.from(json["orders_data"].map((x) => OrdersDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "client_uuid": clientUuid == null ? null : clientUuid,
    "orders_data": ordersData == null ? null : List<dynamic>.from(ordersData.map((x) => x.toJson())),
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
    this.service,
    this.productsData,
    this.driver,
    this.client,
    this.clientUuid,
    this.serviceUuid,
    this.callbackPhone,
    this.featuresUuids,
    this.state,
    this.visibility,
    this.driverArrivalTime,
    this.driverLocation,
    this.freeTime,
  });

  final String uuid;
  final String comment;
  final List<Route> routes;
  final RouteWayData routeWayData;
  final dynamic features;
  final Tariff tariff;
  final Service service;
  final ProductsData productsData;
  final Driver driver;
  final Client client;
  final String clientUuid;
  final String serviceUuid;
  final String callbackPhone;
  final dynamic featuresUuids;
  final String state;
  final bool visibility;
  final int driverArrivalTime;
  final DriverLocation driverLocation;
  final int freeTime;

  factory OrdersDatum.fromJson(Map<String, dynamic> json) => OrdersDatum(
    uuid: json["uuid"] == null ? null : json["uuid"],
    comment: json["comment"] == null ? null : json["comment"],
    routes: json["routes"] == null ? null : List<Route>.from(json["routes"].map((x) => Route.fromJson(x))),
    routeWayData: json["route_way_data"] == null ? null : RouteWayData.fromJson(json["route_way_data"]),
    features: json["features"],
    tariff: json["tariff"] == null ? null : Tariff.fromJson(json["tariff"]),
    service: json["service"] == null ? null : Service.fromJson(json["service"]),
    productsData: json["products_data"] == null ? null : ProductsData.fromJson(json["products_data"]),
    driver: json["driver"] == null ? null : Driver.fromJson(json["driver"]),
    client: json["client"] == null ? null : Client.fromJson(json["client"]),
    clientUuid: json["client_uuid"] == null ? null : json["client_uuid"],
    serviceUuid: json["service_uuid"] == null ? null : json["service_uuid"],
    callbackPhone: json["callback_phone"] == null ? null : json["callback_phone"],
    featuresUuids: json["features_uuids"],
    state: json["state"] == null ? null : json["state"],
    visibility: json["visibility"] == null ? null : json["visibility"],
    driverArrivalTime: json["driver_arrival_time"] == null ? null : json["driver_arrival_time"],
    driverLocation: json["driver_location"] == null ? null : DriverLocation.fromJson(json["driver_location"]),
    freeTime: json["free_time"] == null ? null : json["free_time"],
  );

  Map<String, dynamic> toJson() => {
    "uuid": uuid == null ? null : uuid,
    "comment": comment == null ? null : comment,
    "routes": routes == null ? null : List<dynamic>.from(routes.map((x) => x.toJson())),
    "route_way_data": routeWayData == null ? null : routeWayData.toJson(),
    "features": features,
    "tariff": tariff == null ? null : tariff.toJson(),
    "service": service == null ? null : service.toJson(),
    "products_data": productsData == null ? null : productsData.toJson(),
    "driver": driver == null ? null : driver.toJson(),
    "client": client == null ? null : client.toJson(),
    "client_uuid": clientUuid == null ? null : clientUuid,
    "service_uuid": serviceUuid == null ? null : serviceUuid,
    "callback_phone": callbackPhone == null ? null : callbackPhone,
    "features_uuids": featuresUuids,
    "state": state == null ? null : state,
    "visibility": visibility == null ? null : visibility,
    "driver_arrival_time": driverArrivalTime == null ? null : driverArrivalTime,
    "driver_location": driverLocation == null ? null : driverLocation.toJson(),
    "free_time": freeTime == null ? null : freeTime,
  };
}

class Client {
  Client({
    this.uuid,
    this.name,
    this.karma,
    this.mainPhone,
    this.phones,
    this.comment,
  });

  final String uuid;
  final String name;
  final int karma;
  final String mainPhone;
  final dynamic phones;
  final String comment;

  factory Client.fromJson(Map<String, dynamic> json) => Client(
    uuid: json["uuid"] == null ? null : json["uuid"],
    name: json["name"] == null ? null : json["name"],
    karma: json["karma"] == null ? null : json["karma"],
    mainPhone: json["main_phone"] == null ? null : json["main_phone"],
    phones: json["phones"],
    comment: json["comment"] == null ? null : json["comment"],
  );

  Map<String, dynamic> toJson() => {
    "uuid": uuid == null ? null : uuid,
    "name": name == null ? null : name,
    "karma": karma == null ? null : karma,
    "main_phone": mainPhone == null ? null : mainPhone,
    "phones": phones,
    "comment": comment == null ? null : comment,
  };
}

class Driver {
  Driver({
    this.uuid,
    this.name,
    this.phone,
    this.comment,
    this.car,
    this.karma,
    this.color,
    this.alias,
    this.regNumber,
  });

  final String uuid;
  final String name;
  final String phone;
  final String comment;
  final String car;
  final int karma;
  final String color;
  final String alias;
  final String regNumber;

  factory Driver.fromJson(Map<String, dynamic> json) => Driver(
    uuid: json["uuid"] == null ? null : json["uuid"],
    name: json["name"] == null ? null : json["name"],
    phone: json["phone"] == null ? null : json["phone"],
    comment: json["comment"] == null ? null : json["comment"],
    car: json["car"] == null ? null : json["car"],
    karma: json["karma"] == null ? null : json["karma"],
    color: json["color"] == null ? null : json["color"],
    alias: json["alias"] == null ? null : json["alias"],
    regNumber: json["reg_number"] == null ? null : json["reg_number"],
  );

  Map<String, dynamic> toJson() => {
    "uuid": uuid == null ? null : uuid,
    "name": name == null ? null : name,
    "phone": phone == null ? null : phone,
    "comment": comment == null ? null : comment,
    "car": car == null ? null : car,
    "karma": karma == null ? null : karma,
    "color": color == null ? null : color,
    "alias": alias == null ? null : alias,
    "reg_number": regNumber == null ? null : regNumber,
  };
}

class DriverLocation {
  DriverLocation({
    this.lat,
    this.long,
  });

  final double lat;
  final double long;

  factory DriverLocation.fromJson(Map<String, dynamic> json) => DriverLocation(
    lat: json["lat"] == null ? null : json["lat"].toDouble(),
    long: json["long"] == null ? null : json["long"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "lat": lat == null ? null : lat,
    "long": long == null ? null : long,
  };
}

class ProductsData {
  ProductsData({
    this.store,
    this.preparationTime,
    this.products,
  });

  final Store store;
  final int preparationTime;
  final List<Product> products;

  factory ProductsData.fromJson(Map<String, dynamic> json) => ProductsData(
    store: json["store"] == null ? null : Store.fromJson(json["store"]),
    preparationTime: json["preparation_time"] == null ? null : json["preparation_time"],
    products: json["products"] == null ? null : List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "store": store == null ? null : store.toJson(),
    "preparation_time": preparationTime == null ? null : preparationTime,
    "products": products == null ? null : List<dynamic>.from(products.map((x) => x.toJson())),
  };
}

class Product {
  Product({
    this.uuid,
    this.name,
    this.comment,
    this.price,
    this.image,
    this.number,
    this.storeUuid,
    this.toppings,
    this.selectedVariant,
  });

  final String uuid;
  final String name;
  final String comment;
  final int price;
  final String image;
  final int number;
  final String storeUuid;
  final List<Topping> toppings;
  final SelectedVariant selectedVariant;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    uuid: json["uuid"] == null ? null : json["uuid"],
    name: json["name"] == null ? null : json["name"],
    comment: json["comment"] == null ? null : json["comment"],
    price: json["price"] == null ? null : json["price"],
    image: json["image"] == null ? null : json["image"],
    number: json["number"] == null ? null : json["number"],
    storeUuid: json["store_uuid"] == null ? null : json["store_uuid"],
    toppings: json["toppings"] == null ? null : List<Topping>.from(json["toppings"].map((x) => Topping.fromJson(x))),
    selectedVariant: json["selected_variant"] == null ? null : SelectedVariant.fromJson(json["selected_variant"]),
  );

  Map<String, dynamic> toJson() => {
    "uuid": uuid == null ? null : uuid,
    "name": name == null ? null : name,
    "comment": comment == null ? null : comment,
    "price": price == null ? null : price,
    "image": image == null ? null : image,
    "number": number == null ? null : number,
    "store_uuid": storeUuid == null ? null : storeUuid,
    "toppings": toppings == null ? null : List<dynamic>.from(toppings.map((x) => x.toJson())),
    "selected_variant": selectedVariant == null ? null : selectedVariant.toJson(),
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

  final String uuid;
  final String name;
  final bool standard;
  final int price;
  final String comment;

  factory SelectedVariant.fromJson(Map<String, dynamic> json) => SelectedVariant(
    uuid: json["uuid"] == null ? null : json["uuid"],
    name: json["name"] == null ? null : json["name"],
    standard: json["standard"] == null ? null : json["standard"],
    price: json["price"] == null ? null : json["price"],
    comment: json["comment"] == null ? null : json["comment"],
  );

  Map<String, dynamic> toJson() => {
    "uuid": uuid == null ? null : uuid,
    "name": name == null ? null : name,
    "standard": standard == null ? null : standard,
    "price": price == null ? null : price,
    "comment": comment == null ? null : comment,
  };
}

class Topping {
  Topping({
    this.uuid,
    this.name,
    this.price,
    this.comment,
  });

  final String uuid;
  final String name;
  final int price;
  final String comment;

  factory Topping.fromJson(Map<String, dynamic> json) => Topping(
    uuid: json["uuid"] == null ? null : json["uuid"],
    name: json["name"] == null ? null : json["name"],
    price: json["price"] == null ? null : json["price"],
    comment: json["comment"] == null ? null : json["comment"],
  );

  Map<String, dynamic> toJson() => {
    "uuid": uuid == null ? null : uuid,
    "name": name == null ? null : name,
    "price": price == null ? null : price,
    "comment": comment == null ? null : comment,
  };
}

class Store {
  Store({
    this.uuid,
    this.name,
    this.comment,
    this.image,
    this.workSchedule,
    this.type,
    this.productCategory,
    this.destinationPoints,
    this.destinationPointsUuid,
    this.orderPreparationTimeSecond,
  });

  final String uuid;
  final String name;
  final String comment;
  final String image;
  final List<WorkSchedule> workSchedule;
  final String type;
  final List<String> productCategory;
  final dynamic destinationPoints;
  final List<String> destinationPointsUuid;
  final int orderPreparationTimeSecond;

  factory Store.fromJson(Map<String, dynamic> json) => Store(
    uuid: json["uuid"] == null ? null : json["uuid"],
    name: json["name"] == null ? null : json["name"],
    comment: json["comment"] == null ? null : json["comment"],
    image: json["image"] == null ? null : json["image"],
    workSchedule: json["work_schedule"] == null ? null : List<WorkSchedule>.from(json["work_schedule"].map((x) => WorkSchedule.fromJson(x))),
    type: json["type"] == null ? null : json["type"],
    productCategory: json["product_category"] == null ? null : List<String>.from(json["product_category"].map((x) => x)),
    destinationPoints: json["destination_points"],
    destinationPointsUuid: json["destination_points_uuid"] == null ? null : List<String>.from(json["destination_points_uuid"].map((x) => x)),
    orderPreparationTimeSecond: json["order_preparation_time_second"] == null ? null : json["order_preparation_time_second"],
  );

  Map<String, dynamic> toJson() => {
    "uuid": uuid == null ? null : uuid,
    "name": name == null ? null : name,
    "comment": comment == null ? null : comment,
    "image": image == null ? null : image,
    "work_schedule": workSchedule == null ? null : List<dynamic>.from(workSchedule.map((x) => x.toJson())),
    "type": type == null ? null : type,
    "product_category": productCategory == null ? null : List<dynamic>.from(productCategory.map((x) => x)),
    "destination_points": destinationPoints,
    "destination_points_uuid": destinationPointsUuid == null ? null : List<dynamic>.from(destinationPointsUuid.map((x) => x)),
    "order_preparation_time_second": orderPreparationTimeSecond == null ? null : orderPreparationTimeSecond,
  };
}

class WorkSchedule {
  WorkSchedule({
    this.weekDay,
    this.dayOff,
    this.workBeginning,
    this.workEnding,
  });

  final int weekDay;
  final bool dayOff;
  final int workBeginning;
  final int workEnding;

  factory WorkSchedule.fromJson(Map<String, dynamic> json) => WorkSchedule(
    weekDay: json["week_day"] == null ? null : json["week_day"],
    dayOff: json["day_off"] == null ? null : json["day_off"],
    workBeginning: json["work_beginning"] == null ? null : json["work_beginning"],
    workEnding: json["work_ending"] == null ? null : json["work_ending"],
  );

  Map<String, dynamic> toJson() => {
    "week_day": weekDay == null ? null : weekDay,
    "day_off": dayOff == null ? null : dayOff,
    "work_beginning": workBeginning == null ? null : workBeginning,
    "work_ending": workEnding == null ? null : workEnding,
  };
}

class RouteWayData {
  RouteWayData({
    this.routes,
    this.routeFromDriverToClient,
    this.steps,
  });

  final Routes routes;
  final RouteFromDriverToClient routeFromDriverToClient;
  final List<Step> steps;

  factory RouteWayData.fromJson(Map<String, dynamic> json) => RouteWayData(
    routes: json["routes"] == null ? null : Routes.fromJson(json["routes"]),
    routeFromDriverToClient: json["route_from_driver_to_client"] == null ? null : RouteFromDriverToClient.fromJson(json["route_from_driver_to_client"]),
    steps: json["steps"] == null ? null : List<Step>.from(json["steps"].map((x) => Step.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "routes": routes == null ? null : routes.toJson(),
    "route_from_driver_to_client": routeFromDriverToClient == null ? null : routeFromDriverToClient.toJson(),
    "steps": steps == null ? null : List<dynamic>.from(steps.map((x) => x.toJson())),
  };
}

class RouteFromDriverToClient {
  RouteFromDriverToClient({
    this.geometry,
    this.type,
    this.properties,
  });

  final RouteFromDriverToClientGeometry geometry;
  final String type;
  final RouteFromDriverToClientProperties properties;

  factory RouteFromDriverToClient.fromJson(Map<String, dynamic> json) => RouteFromDriverToClient(
    geometry: json["geometry"] == null ? null : RouteFromDriverToClientGeometry.fromJson(json["geometry"]),
    type: json["type"] == null ? null : json["type"],
    properties: json["properties"] == null ? null : RouteFromDriverToClientProperties.fromJson(json["properties"]),
  );

  Map<String, dynamic> toJson() => {
    "geometry": geometry == null ? null : geometry.toJson(),
    "type": type == null ? null : type,
    "properties": properties == null ? null : properties.toJson(),
  };
}

class RouteFromDriverToClientGeometry {
  RouteFromDriverToClientGeometry({
    this.coordinates,
    this.type,
  });

  final List<List<double>> coordinates;
  final String type;

  factory RouteFromDriverToClientGeometry.fromJson(Map<String, dynamic> json) => RouteFromDriverToClientGeometry(
    coordinates: json["coordinates"] == null ? null : List<List<double>>.from(json["coordinates"].map((x) => List<double>.from(x.map((x) => x.toDouble())))),
    type: json["type"] == null ? null : json["type"],
  );

  Map<String, dynamic> toJson() => {
    "coordinates": coordinates == null ? null : List<dynamic>.from(coordinates.map((x) => List<dynamic>.from(x.map((x) => x)))),
    "type": type == null ? null : type,
  };
}

class RouteFromDriverToClientProperties {
  RouteFromDriverToClientProperties({
    this.duration,
    this.distance,
  });

  final int duration;
  final int distance;

  factory RouteFromDriverToClientProperties.fromJson(Map<String, dynamic> json) => RouteFromDriverToClientProperties(
    duration: json["duration"] == null ? null : json["duration"],
    distance: json["distance"] == null ? null : json["distance"],
  );

  Map<String, dynamic> toJson() => {
    "duration": duration == null ? null : duration,
    "distance": distance == null ? null : distance,
  };
}

class Routes {
  Routes({
    this.geometry,
    this.type,
    this.properties,
  });

  final RoutesGeometry geometry;
  final String type;
  final RouteFromDriverToClientProperties properties;

  factory Routes.fromJson(Map<String, dynamic> json) => Routes(
    geometry: json["geometry"] == null ? null : RoutesGeometry.fromJson(json["geometry"]),
    type: json["type"] == null ? null : json["type"],
    properties: json["properties"] == null ? null : RouteFromDriverToClientProperties.fromJson(json["properties"]),
  );

  Map<String, dynamic> toJson() => {
    "geometry": geometry == null ? null : geometry.toJson(),
    "type": type == null ? null : type,
    "properties": properties == null ? null : properties.toJson(),
  };
}

class RoutesGeometry {
  RoutesGeometry({
    this.coordinates,
    this.type,
  });

  final dynamic coordinates;
  final String type;

  factory RoutesGeometry.fromJson(Map<String, dynamic> json) => RoutesGeometry(
    coordinates: json["coordinates"],
    type: json["type"] == null ? null : json["type"],
  );

  Map<String, dynamic> toJson() => {
    "coordinates": coordinates,
    "type": type == null ? null : type,
  };
}

class Step {
  Step({
    this.geometry,
    this.type,
    this.properties,
  });

  final RouteFromDriverToClientGeometry geometry;
  final String type;
  final StepProperties properties;

  factory Step.fromJson(Map<String, dynamic> json) => Step(
    geometry: json["geometry"] == null ? null : RouteFromDriverToClientGeometry.fromJson(json["geometry"]),
    type: json["type"] == null ? null : json["type"],
    properties: json["properties"] == null ? null : StepProperties.fromJson(json["properties"]),
  );

  Map<String, dynamic> toJson() => {
    "geometry": geometry == null ? null : geometry.toJson(),
    "type": type == null ? null : type,
    "properties": properties == null ? null : properties.toJson(),
  };
}

class StepProperties {
  StepProperties({
    this.duration,
    this.distance,
  });

  final int duration;
  final double distance;

  factory StepProperties.fromJson(Map<String, dynamic> json) => StepProperties(
    duration: json["duration"] == null ? null : json["duration"],
    distance: json["distance"] == null ? null : json["distance"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "duration": duration == null ? null : duration,
    "distance": distance == null ? null : distance,
  };
}

class Route {
  Route({
    this.unrestrictedValue,
    this.value,
    this.country,
    this.region,
    this.regionType,
    this.type,
    this.city,
    this.cityType,
    this.comment,
    this.street,
    this.streetType,
    this.streetWithType,
    this.house,
    this.outOfTown,
    this.houseType,
    this.accuracyLevel,
    this.radius,
    this.lat,
    this.lon,
  });

  final String unrestrictedValue;
  final String value;
  final String country;
  final String region;
  final String regionType;
  final String type;
  final String city;
  final String cityType;
  final String comment;
  final String street;
  final String streetType;
  final String streetWithType;
  final String house;
  final bool outOfTown;
  final String houseType;
  final int accuracyLevel;
  final int radius;
  final double lat;
  final double lon;

  factory Route.fromJson(Map<String, dynamic> json) => Route(
    unrestrictedValue: json["unrestricted_value"] == null ? null : json["unrestricted_value"],
    value: json["value"] == null ? null : json["value"],
    country: json["country"] == null ? null : json["country"],
    region: json["region"] == null ? null : json["region"],
    regionType: json["region_type"] == null ? null : json["region_type"],
    type: json["type"] == null ? null : json["type"],
    city: json["city"] == null ? null : json["city"],
    cityType: json["city_type"] == null ? null : json["city_type"],
    comment: json["comment"] == null ? null : json["comment"],
    street: json["street"] == null ? null : json["street"],
    streetType: json["street_type"] == null ? null : json["street_type"],
    streetWithType: json["street_with_type"] == null ? null : json["street_with_type"],
    house: json["house"] == null ? null : json["house"],
    outOfTown: json["out_of_town"] == null ? null : json["out_of_town"],
    houseType: json["house_type"] == null ? null : json["house_type"],
    accuracyLevel: json["accuracy_level"] == null ? null : json["accuracy_level"],
    radius: json["radius"] == null ? null : json["radius"],
    lat: json["lat"] == null ? null : json["lat"].toDouble(),
    lon: json["lon"] == null ? null : json["lon"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "unrestricted_value": unrestrictedValue == null ? null : unrestrictedValue,
    "value": value == null ? null : value,
    "country": country == null ? null : country,
    "region": region == null ? null : region,
    "region_type": regionType == null ? null : regionType,
    "type": type == null ? null : type,
    "city": city == null ? null : city,
    "city_type": cityType == null ? null : cityType,
    "comment": comment == null ? null : comment,
    "street": street == null ? null : street,
    "street_type": streetType == null ? null : streetType,
    "street_with_type": streetWithType == null ? null : streetWithType,
    "house": house == null ? null : house,
    "out_of_town": outOfTown == null ? null : outOfTown,
    "house_type": houseType == null ? null : houseType,
    "accuracy_level": accuracyLevel == null ? null : accuracyLevel,
    "radius": radius == null ? null : radius,
    "lat": lat == null ? null : lat,
    "lon": lon == null ? null : lon,
  };
}

class Service {
  Service({
    this.uuid,
    this.name,
    this.productDelivery,
    this.comment,
    this.tag,
  });

  final String uuid;
  final String name;
  final bool productDelivery;
  final String comment;
  final List<String> tag;

  factory Service.fromJson(Map<String, dynamic> json) => Service(
    uuid: json["uuid"] == null ? null : json["uuid"],
    name: json["name"] == null ? null : json["name"],
    productDelivery: json["product_delivery"] == null ? null : json["product_delivery"],
    comment: json["comment"] == null ? null : json["comment"],
    tag: json["tag"] == null ? null : List<String>.from(json["tag"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "uuid": uuid == null ? null : uuid,
    "name": name == null ? null : name,
    "product_delivery": productDelivery == null ? null : productDelivery,
    "comment": comment == null ? null : comment,
    "tag": tag == null ? null : List<dynamic>.from(tag.map((x) => x)),
  };
}

class Tariff {
  Tariff({
    this.name,
    this.totalPrice,
    this.currency,
    this.paymentType,
    this.items,
    this.waitingBoarding,
    this.waitingPoint,
  });

  final String name;
  final int totalPrice;
  final String currency;
  final String paymentType;
  final List<Item> items;
  final Map<String, int> waitingBoarding;
  final Map<String, int> waitingPoint;

  factory Tariff.fromJson(Map<String, dynamic> json) => Tariff(
    name: json["name"] == null ? null : json["name"],
    totalPrice: json["total_price"] == null ? null : json["total_price"],
    currency: json["currency"] == null ? null : json["currency"],
    paymentType: json["payment_type"] == null ? null : json["payment_type"],
    items: json["items"] == null ? null : List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
    waitingBoarding: json["waiting_boarding"] == null ? null : Map.from(json["waiting_boarding"]).map((k, v) => MapEntry<String, int>(k, v)),
    waitingPoint: json["waiting_point"] == null ? null : Map.from(json["waiting_point"]).map((k, v) => MapEntry<String, int>(k, v)),
  );

  Map<String, dynamic> toJson() => {
    "name": name == null ? null : name,
    "total_price": totalPrice == null ? null : totalPrice,
    "currency": currency == null ? null : currency,
    "payment_type": paymentType == null ? null : paymentType,
    "items": items == null ? null : List<dynamic>.from(items.map((x) => x.toJson())),
    "waiting_boarding": waitingBoarding == null ? null : Map.from(waitingBoarding).map((k, v) => MapEntry<String, dynamic>(k, v)),
    "waiting_point": waitingPoint == null ? null : Map.from(waitingPoint).map((k, v) => MapEntry<String, dynamic>(k, v)),
  };
}

class Item {
  Item({
    this.name,
    this.price,
  });

  final String name;
  final int price;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    name: json["name"] == null ? null : json["name"],
    price: json["price"] == null ? null : json["price"],
  );

  Map<String, dynamic> toJson() => {
    "name": name == null ? null : name,
    "price": price == null ? null : price,
  };
}
