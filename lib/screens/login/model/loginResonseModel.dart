// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

LoginResponse loginResonseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  LoginResponse({
    required this.token,
    required this.data,
  });

  String token;
  Data data;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    token: json["token"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "token": token,
    "data": data.toJson(),
  };
}

class Data {
  Data({
    required this.profileDetails,
    required this.profileType,
    required this.merchant,
    required this.recentTransactions,
  });

  ProfileDetails profileDetails;
  String profileType;
  Merchant merchant;
  List<RecentTransaction> recentTransactions;

  factory Data.fromJson(Map<String, dynamic> json) {

    var list = json['recentTransactions'] as List;
    List<RecentTransaction> recentTransList = list.map((e) => RecentTransaction.fromJson(e)).toList();
    return Data(
        profileDetails: ProfileDetails.fromJson(json["profileDetails"]),
        profileType: json["profileType"],
        merchant: Merchant.fromJson(json["merchant"]),
        recentTransactions: recentTransList,
    );
  }

  Map<String, dynamic> toJson() => {
    "profileDetails": profileDetails.toJson(),
    "profileType": profileType,
    "merchant": merchant.toJson(),
    "recentTransactions": List<dynamic>.from(recentTransactions.map((x) => x.toJson())),
  };
}

class Merchant {
  Merchant({
    required this.id,
    required this.userId,
    required this.accountNumber,
    required this.accountName,
    required this.bankName,
    required this.numberOfStations,
    required this.depositedFund,
    required this.commission,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  int userId;
  String accountNumber;
  String accountName;
  String bankName;
  int numberOfStations;
  int depositedFund;
  double commission;
  dynamic status;
  DateTime createdAt;
  DateTime updatedAt;

  factory Merchant.fromJson(Map<String, dynamic> json) => Merchant(
    id: json["id"],
    userId: json["user_id"],
    accountNumber: json["account_number"],
    accountName: json["account_name"],
    bankName: json["bank_name"],
    numberOfStations: json["number_of_stations"],
    depositedFund: json["deposited_fund"],
    commission: json["commission"].toDouble(),
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "account_number": accountNumber,
    "account_name": accountName,
    "bank_name": bankName,
    "number_of_stations": numberOfStations,
    "deposited_fund": depositedFund,
    "commission": commission,
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

class ProfileDetails {
  ProfileDetails({
    required this.id,
    required this.userId,
    required this.name,
    required this.address,
    required this.phone,
    required this.email,
    required this.balance,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    required this.city,
    required this.state,
    required this.business,
    required this.vcards,
  });

  int id;
  int userId;
  String name;
  String address;
  String phone;
  String email;
  int balance;
  DateTime createdAt;
  DateTime updatedAt;
  bool status;
  dynamic city;
  dynamic state;
  dynamic business;
  List<Vcard> vcards;

  factory ProfileDetails.fromJson(Map<String, dynamic> json) => ProfileDetails(
    id: json["id"],
    userId: json["user_id"],
    name: json["name"],
    address: json["address"],
    phone: json["phone"],
    email: json["email"],
    balance: json["balance"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    status: json["status"],
    city: json["city"],
    state: json["state"],
    business: json["business"],
    vcards: List<Vcard>.from(json["vcards"].map((x) => Vcard.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "name": name,
    "address": address,
    "phone": phone,
    "email": email,
    "balance": balance,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "status": status,
    "city": city,
    "state": state,
    "business": business,
    "vcards": List<dynamic>.from(vcards.map((x) => x.toJson())),
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
    required this.merchant,
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
  Merchant? merchant;

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
    merchant: json["merchant"] == null ? null : Merchant.fromJson(json["merchant"]),
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
    "merchant": merchant == null ? null : merchant!.toJson(),
  };
}

class RecentTransaction {
  RecentTransaction({
    required this.id,
    required this.vcardId,
    required this.merchantId,
    required this.deviceId,
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
  int amount;
  int balance;
  int comAmount;
  String referenceNo;
  String product;
  String location;
  String status;
  dynamic attendant;
  DateTime createdAt;
  DateTime updatedAt;
  Vcard vcard;

  factory RecentTransaction.fromJson(Map<String, dynamic> json) => RecentTransaction(
    id: json["id"],
    vcardId: json["vcard_id"],
    merchantId: json["merchant_id"],
    deviceId: json["device_id"],
    amount: json["amount"],
    balance: json["balance"],
    comAmount: json["com_amount"],
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
