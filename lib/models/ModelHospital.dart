// To parse this JSON data, do
//
//     final modelHospital = modelHospitalFromJson(jsonString);

import 'dart:convert';

ModelHospital modelHospitalFromJson(String str) => ModelHospital.fromJson(json.decode(str));

String modelHospitalToJson(ModelHospital data) => json.encode(data.toJson());

class ModelHospital {
    String message;
    List<Result> result;

    ModelHospital({
        required this.message,
        required this.result,
    });

    factory ModelHospital.fromJson(Map<String, dynamic> json) => ModelHospital(
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
    String hospital;
    int homestaysId;
    String homestayName;
    String homestayPicture;
    String homestayAddress;
    String googleMaps;

    Result({
        required this.id,
        required this.hospital,
        required this.homestaysId,
        required this.homestayName,
        required this.homestayPicture,
        required this.homestayAddress,
        required this.googleMaps,
    });

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        hospital: json["hospital"],
        homestaysId: json["homestays_id"],
        homestayName: json["homestay_name"],
        homestayPicture: json["homestay_picture"],
        homestayAddress: json["homestay_address"],
        googleMaps: json["google_maps"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "hospital": hospital,
        "homestays_id": homestaysId,
        "homestay_name": homestayName,
        "homestay_picture": homestayPicture,
        "homestay_address": homestayAddress,
        "google_maps": googleMaps,
    };
}
