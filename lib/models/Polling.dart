import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';

// class Poll {
//   final String name;
//   final int votes;
//   final DocumentReference reference;

//   Poll.fromMap(Map<String, dynamic> map, {this.reference})
//       : assert(map['name'] != null),
//         assert(map['votes'] != null),
//         name = map['name'],
//         votes = map['votes'];

//   Poll.fromSnapshot(DocumentSnapshot snapshot)
//       : this.fromMap(snapshot.data, reference: snapshot.reference);

//   @override
//   String toString() => "Record<$name:$votes>";
// }

class Poll {
  String question;
  Map<String, int> options;
  FieldValue time;
  String mode;

  Poll({this.question, this.options, this.time, this.mode});

  Map toMap(Poll poll) {
    Map<String, dynamic> data = Map<String, dynamic>();
    data['question'] = poll.question;
    data['options'] = poll.options;
    data['time'] = poll.time;
    data['mode'] = poll.mode;

    return data;
  }

  Poll.fromMap(Map<String, dynamic> data) {
    this.question = data['question'];
    this.options = data['options'];
    this.time = data['time'];
    this.mode = data['mode'];
  }
}
