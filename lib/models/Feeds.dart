import 'package:cloud_firestore/cloud_firestore.dart';

class Feed {
  String currentUserUid;
  String imgUrl;
  String caption;
  FieldValue time;
  String postOwnerName;
  String postOwnerPhotoUrl;
  String mode;

  Feed(
      {this.currentUserUid,
      this.imgUrl,
      this.caption,
      this.time,
      this.postOwnerName,
      this.postOwnerPhotoUrl,
      this.mode});

  Map toMap(Feed post) {
    Map<String, dynamic> data = Map<String, dynamic>();
    data['ownerUid'] = post.currentUserUid;
    data['imgUrl'] = post.imgUrl;
    data['caption'] = post.caption;
    data['time'] = post.time;
    data['postOwnerName'] = post.postOwnerName;
    data['postOwnerPhotoUrl'] = post.postOwnerPhotoUrl;
    data['mode'] = post.mode;
    return data;
  }

  Feed.fromMap(Map<String, dynamic> mapData) {
    this.currentUserUid = mapData['ownerUid'];
    this.imgUrl = mapData['imgUrl'];
    this.caption = mapData['caption'];
    this.time = mapData['time'];
    this.postOwnerName = mapData['postOwnerName'];
    this.postOwnerPhotoUrl = mapData['postOnerPhotoUrl'];
    this.mode = mapData['mode'];
  }
}
