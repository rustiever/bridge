class User {
  String email;
  String id;
  String photoUrl;
  String username;
  String usn;
  // String joined;
  String batch;
  String branch;
  String token;

  User(
      {this.username,
      this.id,
      this.photoUrl,
      this.email,
      this.usn,
      // this.joined,
      this.batch,
      this.branch,
      this.token});

  User.fromMap(Map<String, dynamic> mapData) {
    this.id = mapData['uid'];
    this.email = mapData['email'];
    this.photoUrl = mapData['photoUrl'];
    // this.joined = mapData['createdAt'];
    this.batch = mapData['batch'];
    this.branch = mapData['branch'];
    this.token = mapData['token'];
    this.usn = mapData['usn'];
    this.username = mapData['userName'];
  }

  Map toMap(User user) {
    var data = Map<String, dynamic>();
    data['uid'] = user.id;
    data['email'] = user.email;
    data['photoUrl'] = user.photoUrl;
    // data['createdAt'] = user.joined;
    data['batch'] = user.batch;
    data['branch'] = user.branch;
    data['usn'] = user.usn;
    data['token'] = user.token;
    data['userName'] = user.username;
    return data;
  }
}
