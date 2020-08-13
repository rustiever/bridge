class User {
  String authorizeToken;
  UserData userData;

  User({this.authorizeToken, this.userData});

  User.fromJson(Map<String, dynamic> json) {
    authorizeToken = json['authorizeToken'];
    userData = json['userData'] != null
        ? new UserData.fromJson(json['userData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['authorizeToken'] = this.authorizeToken;
    if (this.userData != null) {
      data['userData'] = this.userData.toJson();
    }
    return data;
  }
}

class UserData {
  int batch;
  String uSN;
  String email;
  String branch;
  String userID;
  String photoURL;
  String name;
  List<String> token;

  UserData(
      {this.batch,
      this.uSN,
      this.email,
      this.branch,
      this.userID,
      this.photoURL,
      this.name,
      this.token});

  UserData.fromJson(Map<String, dynamic> json) {
    batch = json['Batch'];
    uSN = json['USN'];
    email = json['Email'];
    branch = json['Branch'];
    userID = json['UserID'];
    photoURL = json['PhotoURL'];
    name = json['Name'];
    token = json['token'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Batch'] = this.batch;
    data['USN'] = this.uSN;
    data['Email'] = this.email;
    data['Branch'] = this.branch;
    data['UserID'] = this.userID;
    data['PhotoURL'] = this.photoURL;
    data['Name'] = this.name;
    data['token'] = this.token;
    return data;
  }
}
