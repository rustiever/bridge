// To parse this JSON data, do
//
//     final feedModel = feedModelFromJson(jsonString);

import 'dart:convert';

import 'package:meta/meta.dart';

class FeedDatum {
  final String usertype;

  String ownerPhotoUrl;
  Time timeStamp;
  String ownerName;
  int comlen;
  String caption;
  String photoUrl;
  int likes;
  String ownerUid;
  dynamic scope;
  String postId;
  int comments;
  FeedDatum({
    this.usertype,
    this.ownerPhotoUrl,
    this.timeStamp,
    this.ownerName,
    this.comlen,
    this.caption,
    this.photoUrl,
    this.likes,
    this.ownerUid,
    this.scope,
    this.postId,
    this.comments,
  });

  factory FeedDatum.fromJson(Map<String, dynamic> json) => FeedDatum(
        usertype: json["usertype"] == null ? null : json["usertype"],
        ownerPhotoUrl: json["ownerPhotoUrl"],
        timeStamp: Time.fromJson(json["timeStamp"]),
        ownerName: json["ownerName"],
        comlen: json["comlen"],
        caption: json["caption"] == null ? null : json["caption"],
        photoUrl: json["photoUrl"] == null ? null : json["photoUrl"],
        likes: json["likes"],
        ownerUid: json["ownerUid"],
        scope: json["scope"],
        postId: json["postId"],
        comments: json["comments"],
      );

  factory FeedDatum.fromRawJson(String str) =>
      FeedDatum.fromJson(json.decode(str));

  FeedDatum copyWith({
    String usertype,
    String ownerPhotoUrl,
    Time timeStamp,
    String ownerName,
    int comlen,
    String caption,
    String photoUrl,
    int likes,
    String ownerUid,
    dynamic scope,
    String postId,
    int comments,
  }) =>
      FeedDatum(
        usertype: usertype ?? this.usertype,
        ownerPhotoUrl: ownerPhotoUrl ?? this.ownerPhotoUrl,
        timeStamp: timeStamp ?? this.timeStamp,
        ownerName: ownerName ?? this.ownerName,
        comlen: comlen ?? this.comlen,
        caption: caption ?? this.caption,
        photoUrl: photoUrl ?? this.photoUrl,
        likes: likes ?? this.likes,
        ownerUid: ownerUid ?? this.ownerUid,
        scope: scope ?? this.scope,
        postId: postId ?? this.postId,
        comments: comments ?? this.comments,
      );

  Map<String, dynamic> toJson() => {
        "usertype": usertype == null ? null : usertype,
        "ownerPhotoUrl": ownerPhotoUrl,
        "timeStamp": timeStamp.toJson(),
        "ownerName": ownerName,
        "comlen": comlen,
        "caption": caption == null ? null : caption,
        "photoUrl": photoUrl == null ? null : photoUrl,
        "likes": likes,
        "ownerUid": ownerUid,
        "scope": scope,
        "postId": postId,
        "comments": comments,
      };

  String toRawJson() => json.encode(toJson());
}

class FeedModel {
  final dynamic lastTime;

  final List<FeedDatum> feedData;
  FeedModel({
    this.lastTime,
    this.feedData,
  });

  factory FeedModel.fromJson(Map<String, dynamic> json) => FeedModel(
        lastTime: json["lastTime"],
        feedData: List<FeedDatum>.from(
            json["feedData"].map((x) => FeedDatum.fromJson(x))),
      );

  factory FeedModel.fromRawJson(String str) =>
      FeedModel.fromJson(json.decode(str));

  FeedModel copyWith({
    dynamic lastTime,
    List<FeedDatum> feedData,
  }) =>
      FeedModel(
        lastTime: lastTime ?? this.lastTime,
        feedData: feedData ?? this.feedData,
      );

  Map<String, dynamic> toJson() => {
        "lastTime": lastTime,
        "feedData": List<dynamic>.from(feedData.map((x) => x.toJson())),
      };

  String toRawJson() => json.encode(toJson());
}

class ScopeClass {
  final dynamic branch;
  final dynamic batch;
  final bool groups;
  ScopeClass({
    @required this.branch,
    @required this.batch,
    @required this.groups,
  });

  factory ScopeClass.fromJson(Map<String, dynamic> json) => ScopeClass(
        branch: json["branch"],
        batch: json["batch"],
        groups: json["groups"],
      );

  factory ScopeClass.fromRawJson(String str) =>
      ScopeClass.fromJson(json.decode(str));

  ScopeClass copyWith({
    dynamic branch,
    dynamic batch,
    bool groups,
  }) =>
      ScopeClass(
        branch: branch ?? this.branch,
        batch: batch ?? this.batch,
        groups: groups ?? this.groups,
      );

  Map<String, dynamic> toJson() => {
        "branch": branch,
        "batch": batch,
        "groups": groups,
      };

  String toRawJson() => json.encode(toJson());
}

class Time {
  final int seconds;

  final int nanoseconds;
  Time({
    @required this.seconds,
    @required this.nanoseconds,
  });

  factory Time.fromJson(Map<String, dynamic> json) => Time(
        seconds: json["seconds"],
        nanoseconds: json["nanoseconds"],
      );

  factory Time.fromRawJson(String str) => Time.fromJson(json.decode(str));

  Time copyWith({
    int seconds,
    int nanoseconds,
  }) =>
      Time(
        seconds: seconds ?? this.seconds,
        nanoseconds: nanoseconds ?? this.nanoseconds,
      );

  Map<String, dynamic> toJson() => {
        "seconds": seconds,
        "nanoseconds": nanoseconds,
      };

  String toRawJson() => json.encode(toJson());
}
