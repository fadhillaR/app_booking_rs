// To parse this JSON data, do
//
//     final modelBooking = modelBookingFromJson(jsonString);

import 'dart:convert';

ModelBooking modelBookingFromJson(String str) => ModelBooking.fromJson(json.decode(str));

String modelBookingToJson(ModelBooking data) => json.encode(data.toJson());

class ModelBooking {
    String message;
    List<Result> result;

    ModelBooking({
        required this.message,
        required this.result,
    });

    factory ModelBooking.fromJson(Map<String, dynamic> json) => ModelBooking(
        message: json["message"],
        result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "result": List<dynamic>.from(result.map((x) => x.toJson())),
    };
}

class Result {
    int id;
    int userId;
    int homestaysId;
    String homestayName;
    int roomsId;
    String roomsType;
    int day;
    String totalPrice;
    String status;
    String statusRoom;
    DateTime createdAt;

    Result({
        required this.id,
        required this.userId,
        required this.homestaysId,
        required this.homestayName,
        required this.roomsId,
        required this.roomsType,
        required this.day,
        required this.totalPrice,
        required this.status,
        required this.statusRoom,
        required this.createdAt,
    });

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        userId: json["user_id"],
        homestaysId: json["homestays_id"],
        homestayName: json["homestay_name"],
        roomsId: json["rooms_id"],
        roomsType: json["rooms_type"],
        day: json["day"],
        totalPrice: json["total_price"],
        status: json["status"],
        statusRoom: json["status_room"],
        createdAt: DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "homestays_id": homestaysId,
        "homestay_name": homestayName,
        "rooms_id": roomsId,
        "rooms_type": roomsType,
        "day": day,
        "total_price": totalPrice,
        "status": status,
        "status_room": statusRoom,
        "created_at": createdAt.toIso8601String(),
    };
}
