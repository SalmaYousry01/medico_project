import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../models/my_doctor.dart';

class Search extends SearchDelegate {
  static const String routeName = "Search";
  CollectionReference _firebaseFirestore =
      FirebaseFirestore.instance.collection(DoctorDataBase.COLLECTION_NAME);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: Icon(Icons.close))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _firebaseFirestore.snapshots().asBroadcastStream(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.data!.docs
              .where((QueryDocumentSnapshot<Object?> element) =>
                  element['fullName']
                      .toString()
                      .toLowerCase()
                      .contains(query.toLowerCase()))
              .isEmpty) {
            return Center(
              child: Text("No search query found"),
            );
          }
          // print(snapshot.data);
          else {
            return ListView(children: [
              ...snapshot.data!.docs
                  .where((QueryDocumentSnapshot<Object?> element) =>
                      element['fullName']
                          .toString()
                          .toLowerCase()
                          .contains(query.toLowerCase()))
                  .map((QueryDocumentSnapshot<Object?> data) {
                    final String name = data.get('fullName');
                    final String field = data['Field'];
                    final image = data['image'];

                    return ListTile(
                      onTap: () {},
                      title: Text(name),
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(image),
                      ),
                      subtitle: Text(field),
                    );
                  })
                  .toList()
                  .cast()
            ]);
          }
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(child: Text("Search Doctor here"));
  }
}

@override
Widget build(BuildContext context) {
  return Scaffold();
}
