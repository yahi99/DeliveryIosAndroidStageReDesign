
import 'dart:convert';

import 'package:flutter_app/models/OrderStoryModel.dart';

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
  List<OrdersStoryModelItem> ordersData;

  factory InitData.fromJson(Map<String, dynamic> json) => InitData(
    clientUuid: json["client_uuid"],
    clientPhone: json["client_phone"],
    defaultPaymentType: json["default_payment_type"],
    referralCode: json["referral_code"],
    ordersData: (json["orders_data"] == null) ? null : List<OrdersStoryModelItem>.from(json["orders_data"].map((x) => OrdersStoryModelItem.fromJson(x))),
  );
}