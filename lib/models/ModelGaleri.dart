// To parse this JSON data, do
//
//     final modelGaleri = modelGaleriFromJson(jsonString);

import 'dart:convert';

ModelGaleri modelGaleriFromJson(String str) => ModelGaleri.fromJson(json.decode(str));

String modelGaleriToJson(ModelGaleri data) => json.encode(data.toJson());

class ModelGaleri {
    String message;
    List<Result> result;

    ModelGaleri({
        required this.message,
        required this.result,
    });

    factory ModelGaleri.fromJson(Map<String, dynamic> json) => ModelGaleri(
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
    String picture;

    Result({
        required this.id,
        required this.picture,
    });

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        picture: json["picture"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "picture": picture,
    };
}
