// To parse this JSON data, do
//
//     final modelHomestay = modelHomestayFromJson(jsonString);

import 'dart:convert';

ModelHomestay modelHomestayFromJson(String str) => ModelHomestay.fromJson(json.decode(str));

String modelHomestayToJson(ModelHomestay data) => json.encode(data.toJson());

class ModelHomestay {
    String message;
    List<Result> result;

    ModelHomestay({
        required this.message,
        required this.result,
    });

    factory ModelHomestay.fromJson(Map<String, dynamic> json) => ModelHomestay(
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
    String name;
    String address;
    String picture;

    Result({
        required this.id,
        required this.name,
        required this.address,
        required this.picture,
    });

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        name: json["name"],
        address: json["address"],
        picture: json["picture"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "address": address,
        "picture": picture,
    };
}
