class AnonFeed {
  List<Data> data;

  AnonFeed({this.data});

  AnonFeed.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String imgUrl;
  String ownerId;
  String mode;
  String caption;
  String time;
  String postOwnerName;
  bool global;
  String postOwnerPhotoUrl;

  Data(
      {this.imgUrl,
      this.ownerId,
      this.mode,
      this.caption,
      this.time,
      this.postOwnerName,
      this.global,
      this.postOwnerPhotoUrl});

  Data.fromJson(Map<String, dynamic> json) {
    imgUrl = json['imgUrl'];
    ownerId = json['ownerId'];
    mode = json['mode'];
    caption = json['caption'];
    time = json['time'];
    postOwnerName = json['postOwnerName'];
    global = json['global'];
    postOwnerPhotoUrl = json['postOwnerPhotoUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imgUrl'] = this.imgUrl;
    data['ownerId'] = this.ownerId;
    data['mode'] = this.mode;
    data['caption'] = this.caption;
    data['time'] = this.time;
    data['postOwnerName'] = this.postOwnerName;
    data['global'] = this.global;
    data['postOwnerPhotoUrl'] = this.postOwnerPhotoUrl;
    return data;
  }
}
