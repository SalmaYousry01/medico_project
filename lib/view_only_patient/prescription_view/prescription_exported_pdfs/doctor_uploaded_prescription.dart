import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grad_project/Home_layout/prescription/pateint_uploaded_prescriptions/patient_prescreption.dart';
import '../../../models/my_prescription__exported_pdf.dart';

class PrescListPage extends StatelessWidget {
  final Stream<QuerySnapshot<Myprescpdf>>? myPrescriptionStream;

  PrescListPage({required this.myPrescriptionStream});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Color(0xFF2C698D),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        title: Text('Prescription List'),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: myPrescriptionStream,
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, i) {
                  QueryDocumentSnapshot x = snapshot.data!.docs[i];
                  return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => view(
                                  url: x['fileUrl'],
                                  // image: x["image"],
                                )));
                        // NetworkImage(image!);
                      },
                      child: Container(
                        margin:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        padding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Color(0xFF2C698D))),
                        child: Container(
                          child: Row(
                            children: [
                              Container(
                                height: 70,
                                width: 7,
                                color: Color(0xFF2C698D),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      x["num"],
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Color(0xFF2C698D)),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ));
                });
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
