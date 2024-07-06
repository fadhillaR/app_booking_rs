// To parse this JSON data, do
//
//     final modelFavorite = modelFavoriteFromJson(jsonString);

import 'dart:convert';

ModelFavorite modelFavoriteFromJson(String str) => ModelFavorite.fromJson(json.decode(str));

String modelFavoriteToJson(ModelFavorite data) => json.encode(data.toJson());

class ModelFavorite {
    String message;
    List<Result> result;

    ModelFavorite({
        required this.message,
        required this.result,
    });

    factory ModelFavorite.fromJson(Map<String, dynamic> json) => ModelFavorite(
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
    String name;
    int homestaysId;
    String homestayName;
    String homestayPicture;
    String homestayAddress;

    Result({
        required this.id,
        required this.userId,
        required this.name,
        required this.homestaysId,
        required this.homestayName,
        required this.homestayPicture,
        required this.homestayAddress,
    });

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        userId: json["user_id"],
        name: json["name"],
        homestaysId: json["homestays_id"],
        homestayName: json["homestay_name"],
        homestayPicture: json["homestay_picture"],
        homestayAddress: json["homestay_address"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "name": name,
        "homestays_id": homestaysId,
        "homestay_name": homestayName,
        "homestay_picture": homestayPicture,
        "homestay_address": homestayAddress,
    };
}
