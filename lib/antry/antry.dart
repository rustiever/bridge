import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AllinOne extends StatefulWidget {
  @override
  AllinOneState createState() => AllinOneState();
}

class AllinOneState extends State<AllinOne> {
  Future getPosts() async {
    var fireStore = Firestore.instance;
    final deb = await fireStore.collection('ppost').getDocuments();
    print(deb.documents);
    return deb.documents;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getPosts(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(
              child: Text("waiting"),
            );
          else
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (_, index) {
                return Container(
                  child: Column(
                    children: <Widget>[
                      Text(snapshot.data[index].data['title']),
                      Image(
                        // frameBuilder: (_, child, frame, wasAsync) {
                        //   if (wasAsync )
                        //     return child;
                        //   return AnimatedOpacity(opacity: frame == null ? 0 : 1, duration: Duration(seconds: 1));
                        // },
                        loadingBuilder: (_, child, progress) {
                          if (progress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                        image: NetworkImage(
                          snapshot.data[index].data['imgUrl'],
                        ),
                      ),
                      Text(snapshot.data[index].data['desc'])
                    ],
                  ),
                  // subtitle: Text(snapshot.data[index].data['desc']),
                );
              },
            );
        },
      ),
    );
  }
}
