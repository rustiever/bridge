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

  final dynamic lastTime;
  final List<CommentDatum> commentData;

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
    @required this.comment,
    @required this.edited,
    @required this.photoUrl,
    @required this.name,
  });

  final String id;
  final CommentTimestamp time;
  final String comment;
  final bool edited;
  final String photoUrl;
  final String name;

  factory CommentDatum.fromRawJson(String str) =>
      CommentDatum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CommentDatum.fromJson(Map<String, dynamic> json) => CommentDatum(
        id: json["id"] == null ? null : json["id"],
        time: json["time"] == null
            ? null
            : CommentTimestamp.fromJson(json["time"]),
        comment: json["comment"] == null ? null : json["comment"],
        edited: json["edited"] == null ? null : json["edited"],
        photoUrl: json["photoUrl"] == null ? null : json["photoUrl"],
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "time": time == null ? null : time.toJson(),
        "comment": comment == null ? null : comment,
        "edited": edited == null ? null : edited,
        "photoUrl": photoUrl == null ? null : photoUrl,
        "name": name == null ? null : name,
      };
}

class CommentTimestamp {
  CommentTimestamp({
    @required this.seconds,
    @required this.nanoseconds,
  });

  final int seconds;
  final int nanoseconds;

  factory CommentTimestamp.fromRawJson(String str) =>
      CommentTimestamp.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CommentTimestamp.fromJson(Map<String, dynamic> json) =>
      CommentTimestamp(
        seconds: json["seconds"] == null ? null : json["seconds"],
        nanoseconds: json["nanoseconds"] == null ? null : json["nanoseconds"],
      );

  Map<String, dynamic> toJson() => {
        "seconds": seconds == null ? null : seconds,
        "nanoseconds": nanoseconds == null ? null : nanoseconds,
      };
}
