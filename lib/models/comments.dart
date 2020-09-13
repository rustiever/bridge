// To parse this JSON data, do
//
//     final commentModel = commentModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class CommentModel {
  CommentModel({
    @required this.lastTime,
    @required this.commentData,
  });

  dynamic lastTime;
  List<CommentDatum> commentData;

  factory CommentModel.fromRawJson(String str) =>
      CommentModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
        lastTime: json["lastTime"],
        commentData: json["commentData"] == null
            ? null
            : List<CommentDatum>.from(
                json["commentData"].map((x) => CommentDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "lastTime": lastTime,
        "commentData": commentData == null
            ? null
            : List<dynamic>.from(commentData.map((x) => x.toJson())),
      };
}

class CommentDatum {
  CommentDatum({
    @required this.id,
    @required this.time,
    @required this.edited,
    @required this.name,
  });

  String id;
  dynamic time;
  bool edited;
  String name;

  factory CommentDatum.fromRawJson(String str) =>
      CommentDatum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CommentDatum.fromJson(Map<String, dynamic> json) => CommentDatum(
        id: json["id"] == null ? null : json["id"],
        time: json["time"] == null ? null : json["time"],
        edited: json["edited"] == null ? null : json["edited"],
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "time": time == null ? null : time.toJson(),
        "edited": edited == null ? null : edited,
        "name": name == null ? null : name,
      };
}
