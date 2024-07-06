// To parse this JSON data, do
//
//     final modelRoom = modelRoomFromJson(jsonString);

import 'dart:convert';

ModelRoom modelRoomFromJson(String str) => ModelRoom.fromJson(json.decode(str));

String modelRoomToJson(ModelRoom data) => json.encode(data.toJson());

class ModelRoom {
    String message;
    List<Result> result;

    ModelRoom({
        required this.message,
        required this.result,
    });

    factory ModelRoom.fromJson(Map<String, dynamic> json) => ModelRoom(
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
    int homestaysId;
    String homestayName;
    String type;
    String description;
    int quota;
    String price;
    List<Picture> picture;

    Result({
        required this.id,
        required this.homestaysId,
        required this.homestayName,
        required this.type,
        required this.description,
        required this.quota,
        required this.price,
        required this.picture,
    });

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        homestaysId: json["homestays_id"],
        homestayName: json["homestay_name"],
        type: json["type"],
        description: json["description"],
        quota: json["quota"],
        price: json["price"],
        picture: List<Picture>.from(json["picture"].map((x) => Picture.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "homestays_id": homestaysId,
        "homestay_name": homestayName,
        "type": type,
        "description": description,
        "quota": quota,
        "price": price,
        "picture": List<dynamic>.from(picture.map((x) => x.toJson())),
    };
}

class Picture {
    int id;
    int roomId;
    String filename;
    DateTime createdAt;
    // DateTime updatedAt;
    DateTime? updatedAt;

    Picture({
        required this.id,
        required this.roomId,
        required this.filename,
        required this.createdAt,
        // required this.updatedAt,
        this.updatedAt,
    });

    factory Picture.fromJson(Map<String, dynamic> json) => Picture(
        id: json["id"],
        roomId: json["room_id"],
        filename: json["filename"],
        createdAt: DateTime.parse(json["created_at"]),
        // updatedAt: DateTime.parse(json["updated_at"]),
        updatedAt: json["updated_at"] != null ? DateTime.parse(json["updated_at"]) : null,
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "room_id": roomId,
        "filename": filename,
        "created_at": createdAt.toIso8601String(),
        // "updated_at": updatedAt.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}
