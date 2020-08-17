class FeedModel {
  List<FeedData> feedData;

  FeedModel({this.feedData});

  FeedModel.fromJson(Map<String, dynamic> json) {
    if (json['feedData'] != null) {
      feedData = new List<FeedData>();
      json['feedData'].forEach((v) {
        feedData.add(new FeedData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.feedData != null) {
      data['feedData'] = this.feedData.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FeedData {
  String postId;
  String caption;
  List<String> likes;
  String photoUrl;
  String scope;
  String ownerName;
  String ownerPhotoUrl;
  String ownerUid;
  int timeStamp;
  int comments;

  FeedData(
      {this.postId,
      this.caption,
      this.likes,
      this.photoUrl,
      this.scope,
      this.ownerName,
      this.ownerPhotoUrl,
      this.ownerUid,
      this.timeStamp,
      this.comments});

  FeedData.fromJson(Map<String, dynamic> json) {
    postId = json['postId'];
    caption = json['caption'];
    likes = json['likes'].cast<String>();
    photoUrl = json['photoUrl'];
    scope = json['scope'];
    ownerName = json['ownerName'];
    ownerPhotoUrl = json['ownerPhotoUrl'];
    ownerUid = json['ownerUid'];
    timeStamp = json['timeStamp'];
    comments = json['comments'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['postId'] = this.postId;
    data['caption'] = this.caption;
    data['likes'] = this.likes;
    data['photoUrl'] = this.photoUrl;
    data['scope'] = this.scope;
    data['ownerName'] = this.ownerName;
    data['ownerPhotoUrl'] = this.ownerPhotoUrl;
    data['ownerUid'] = this.ownerUid;
    data['timeStamp'] = this.timeStamp;
    data['comments'] = this.comments;
    return data;
  }
}
