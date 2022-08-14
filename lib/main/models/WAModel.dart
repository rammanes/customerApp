

import 'dart:convert';

class Transactions {
  double? amount;
  String? date;
  String? status;
  String? location;
  String? transType;

  Transactions({this.amount, this.date, this.status, this.location, this.transType});
}


CardLimit cardLimitFromJson(String str) => CardLimit.fromJson(json.decode(str));

String cardLimitToJson(CardLimit data) => json.encode(data.toJson());

class CardLimit {
  CardLimit({
    required this.dailyLimit,
    required this.monthlyLimit,
  });

  String dailyLimit;
  String monthlyLimit;

  factory CardLimit.fromJson(Map<String, dynamic> json) => CardLimit(
    dailyLimit: json["daily_limit"],
    monthlyLimit: json["monthly_limit"],
  );

  Map<String, dynamic> toJson() => {
    "daily_limit": dailyLimit,
    "monthly_limit": monthlyLimit,
  };
}
