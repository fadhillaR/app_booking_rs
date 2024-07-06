import 'dart:convert';

ModelReview modelReviewFromJson(String str) => ModelReview.fromJson(json.decode(str));

String modelReviewToJson(ModelReview data) => json.encode(data.toJson());

class ModelReview {
  String message;
  List<ReviewResult> result;

  ModelReview({
    required this.message,
    required this.result,
  });

  factory ModelReview.fromJson(Map<String, dynamic> json) => ModelReview(
    message: json["message"],
    result: List<ReviewResult>.from(json["result"].map((x) => ReviewResult.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
  };
}

class ReviewResult {
  int id;
  int userId;
  int homestaysId;
  String homestayName;
  String rating;
  String review;
  DateTime createdAt;
  User? user;

  ReviewResult({
    required this.id,
    required this.userId,
    required this.homestaysId,
    required this.homestayName,
    required this.rating,
    required this.review,
    required this.createdAt,
    this.user,
  });

  factory ReviewResult.fromJson(Map<String, dynamic> json) => ReviewResult(
    id: json["id"],
    userId: json["user_id"],
    homestaysId: json["homestays_id"],
    homestayName: json["homestay_name"] ?? '',
    rating: json["rating"] ?? '',
    review: json["review"] ?? '',
    createdAt: DateTime.parse(json["created_at"]),
    user: json["user"] != null ? User.fromJson(json["user"]) : null,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "homestays_id": homestaysId,
    "homestay_name": homestayName,
    "rating": rating,
    "review": review,
    "created_at": createdAt.toIso8601String(),
    "user": user?.toJson(),
  };
}

class User {
  int id;
  String name;

  User({
    required this.id,
    required this.name,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
