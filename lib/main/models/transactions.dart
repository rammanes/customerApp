// To parse required this JSON data, do
//
//     final transactionModel = transactionModelFromJson(jsonString);

import 'dart:convert';

TransactionModel transactionModelFromJson(String str) => TransactionModel.fromJson(json.decode(str));

String transactionModelToJson(TransactionModel data) => json.encode(data.toJson());

class TransactionModel {
  TransactionModel({
    required this.data,
  });

  List<Datum> data;

  factory TransactionModel.fromJson(Map<String, dynamic> json) => TransactionModel(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    required this.id,
    required this.vcardId,
    required this.merchantId,
    required this.deviceId,
    required this.stationId,
    required this.amount,
    required this.balance,
    required this.comAmount,
    required this.referenceNo,
    required this.product,
    required this.location,
    required this.status,
    required this.attendant,
    required this.createdAt,
    required this.updatedAt,
    required this.vcard,
  });

  int id;
  int vcardId;
  int merchantId;
  int deviceId;
  int stationId;
  int amount;
  int balance;
  double comAmount;
  String referenceNo;
  String product;
  String location;
  String status;
  dynamic attendant;
  DateTime createdAt;
  DateTime updatedAt;
  Vcard vcard;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    vcardId: json["vcard_id"],
    merchantId: json["merchant_id"],
    deviceId: json["device_id"],
    stationId: json["station_id"],
    amount: json["amount"],
    balance: json["balance"],
    comAmount: json["com_amount"].toDouble(),
    referenceNo: json["reference_no"],
    product: json["product"],
    location: json["location"],
    status: json["status"],
    attendant: json["attendant"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    vcard: Vcard.fromJson(json["vcard"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "vcard_id": vcardId,
    "merchant_id": merchantId,
    "device_id": deviceId,
    "station_id": stationId,
    "amount": amount,
    "balance": balance,
    "com_amount": comAmount,
    "reference_no": referenceNo,
    "product": product,
    "location": location,
    "status": status,
    "attendant": attendant,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "vcard": vcard.toJson(),
  };
}

class Vcard {
  Vcard({
    required this.id,
    required this.profileId,
    required this.merchantId,
    required this.cardUid,
    required this.cardNumber,
    required this.pin,
    required this.status,
    required this.dailyLimit,
    required this.monthlyLimit,
    required this.expirationDate,
    required this.commission,
    required this.cardType,
    required this.products,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  int profileId;
  int merchantId;
  String cardUid;
  String cardNumber;
  String pin;
  int status;
  int dailyLimit;
  int monthlyLimit;
  DateTime expirationDate;
  int commission;
  String cardType;
  String products;
  DateTime createdAt;
  DateTime updatedAt;

  factory Vcard.fromJson(Map<String, dynamic> json) => Vcard(
    id: json["id"],
    profileId: json["profile_id"],
    merchantId: json["merchant_id"],
    cardUid: json["card_uid"],
    cardNumber: json["card_number"],
    pin: json["pin"],
    status: json["status"],
    dailyLimit: json["daily_limit"],
    monthlyLimit: json["monthly_limit"],
    expirationDate: DateTime.parse(json["expiration_date"]),
    commission: json["commission"],
    cardType: json["card_type"],
    products: json["products"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "profile_id": profileId,
    "merchant_id": merchantId,
    "card_uid": cardUid,
    "card_number": cardNumber,
    "pin": pin,
    "status": status,
    "daily_limit": dailyLimit,
    "monthly_limit": monthlyLimit,
    "expiration_date": "${expirationDate.year.toString().padLeft(4, '0')}-${expirationDate.month.toString().padLeft(2, '0')}-${expirationDate.day.toString().padLeft(2, '0')}",
    "commission": commission,
    "card_type": cardType,
    "products": products,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
