import 'package:cloud_firestore/cloud_firestore.dart';

class DataBase {

  DataBase({this.uid});

  final String  uid;

  final CollectionReference deb = Firestore.instance.collection('try');

  Future updateUserData(String ss, String s,int qn) async {
    return await deb.document(uid).setData(
      {
        'ss': ss,
        's': s,
        'qn': qn
      }
    );
  }

}