class User {
  UserData userData;
  String authorizeToken;

  User({this.userData, this.authorizeToken});

  User.fromJson(Map<String, dynamic> json) {
    userData = json['userData'] != null
        ? new UserData.fromJson(json['userData'])
        : null;
    authorizeToken = json['authorizeToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userData != null) {
      data['userData'] = this.userData.toJson();
    }
    data['authorizeToken'] = this.authorizeToken;
    return data;
  }
}

class UserData {
  String uid;
  String name;
  String email;
  String photoUrl;
  String usn;
  String branch;
  int batch;

  UserData(
      {this.uid,
      this.name,
      this.email,
      this.photoUrl,
      this.usn,
      this.branch,
      this.batch});

  UserData.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    name = json['name'];
    email = json['email'];
    photoUrl = json['photoUrl'];
    usn = json['usn'];
    branch = json['branch'];
    batch = json['batch'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['name'] = this.name;
    data['email'] = this.email;
    data['photoUrl'] = this.photoUrl;
    data['usn'] = this.usn;
    data['branch'] = this.branch;
    data['batch'] = this.batch;
    return data;
  }
}
