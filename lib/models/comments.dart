// To parse this JSON data, do
//
//     final commentModel = commentModelFromJson(jsonString);

import 'dart:convert';

import 'package:meta/meta.dart';

class CommentModel {
  CommentModel({
    @required this.lastTime,
    @required this.commentData,
  });

  dynamic lastTime;
  List<CommentDatum> commentData;

  factory CommentModel.fromRawJson(String str) =>
      CommentModel.fromJson(json.decode(str) as Map<String, dynamic>);

  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
        lastTime: json["lastTime"],
        commentData: json["commentData"] == null
            ? null
            : List<CommentDatum>.from(
                json["commentData"].map(
                  (Map<String, dynamic> x) => CommentDatum.fromJson(x),
                ) as List<Iterable>,
              ),
      );
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
      CommentDatum.fromJson(json.decode(str) as Map<String, dynamic>);

  factory CommentDatum.fromJson(Map<String, dynamic> json) => CommentDatum(
        id: json['id'] as String,
        // id: json["id"] == null ? null : json["id"],
        time: json["time"],
        edited: json["edited"] as bool,
        name: json["name"] as String,
      );
}
