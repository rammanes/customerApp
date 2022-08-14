// To parse this JSON data, do
//
//     final pin = pinFromJson(jsonString);

import 'dart:convert';

List<Pin> pinFromJson(String str) => List<Pin>.from(json.decode(str).map((x) => Pin.fromJson(x)));

String pinToJson(List<Pin> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Pin {
  Pin({
    required this.profileId,
    required this.merchantId,
    required this.pin,
    required this.expirationDate,
    required this.amount,
    required this.product,
    required this.status,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  int profileId;
  int merchantId;
  int pin;
  DateTime expirationDate;
  int amount;
  String product;
  int status;
  DateTime updatedAt;
  DateTime createdAt;
  int id;

  factory Pin.fromJson(Map<String, dynamic> json) => Pin(
    profileId: json["profile_id"],
    merchantId: json["merchant_id"],
    pin: json["pin"],
    expirationDate: DateTime.parse(json["expiration_date"]),
    amount: json["amount"],
    product: json["product"],
    status: json["status"],
    updatedAt: DateTime.parse(json["updated_at"]),
    createdAt: DateTime.parse(json["created_at"]),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "profile_id": profileId,
    "merchant_id": merchantId,
    "pin": pin,
    "expiration_date": expirationDate.toIso8601String(),
    "amount": amount,
    "product": product,
    "status": status,
    "updated_at": updatedAt.toIso8601String(),
    "created_at": createdAt.toIso8601String(),
    "id": id,
  };
}
