// To parse this JSON data, do
//
//     final topUpBody = topUpBodyFromJson(jsonString);

import 'dart:convert';

TopUpBody topUpBodyFromJson(String str) => TopUpBody.fromJson(json.decode(str));

String topUpBodyToJson(TopUpBody data) => json.encode(data.toJson());

class TopUpBody {
  TopUpBody({
    required this.referenceId,
    required this.amount,
    required this.currency,
    required this.callbackUrl,
    required this.redirectUrl,
    required this.payload,
  });

  String referenceId;
  int amount;
  String currency;
  String callbackUrl;
  String redirectUrl;
  List<Payload> payload;

  factory TopUpBody.fromJson(Map<String, dynamic> json) => TopUpBody(
    referenceId: json["reference_id"],
    amount: json["amount"],
    currency: json["currency"],
    callbackUrl: json["callback_url"],
    redirectUrl: json["redirect_url"],
    payload:List<Payload>.from(json["transactions"].map((x) => Payload.fromJson(x)))
  );

  Map<String, dynamic> toJson() => {
    "reference_id": referenceId,
    "amount": amount,
    "currency": currency,
    "callback_url": callbackUrl,
    "redirect_url": redirectUrl,
    "payload": List<dynamic>.from(payload.map((x) => x.toJson())),
  };
}

class Payload {
  Payload({
    required this.userId,
    required this.referenceId,
  });

  int userId;
  String referenceId;

  factory Payload.fromJson(Map<String, dynamic> json) => Payload(
    userId: json["user_id"],
    referenceId: json["reference_id"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "reference_id": referenceId,
  };
}


TopUpResponse topUpResponseFromJson(String str) => TopUpResponse.fromJson(json.decode(str));

String topUpResponseToJson(TopUpResponse data) => json.encode(data.toJson());

class TopUpResponse {
  TopUpResponse({
    required this.status,
    required this.message,
    required this.traceId,
    required this.referenceId,
    required this.url
  });

  bool status;
  String message;
  String traceId;
  String referenceId;
  String url;

  factory TopUpResponse.fromJson(Map<String, dynamic> json) => TopUpResponse(
    status: json["status"],
    message: json["message"],
    traceId: json["trace_id"],
    referenceId: json["reference_id"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "trace_id": traceId,
    "reference_id": referenceId,
    "url":url
  };
}
