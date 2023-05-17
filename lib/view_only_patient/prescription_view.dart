import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../../../models/my_prescription.dart';
import '../DatabaseUtils/prescription_database.dart';
import '../Home_layout/prescription/pateint_uploaded_prescriptions/prescription_navigator.dart';
import '../Home_layout/prescription/pateint_uploaded_prescriptions/prescription_viewmodel.dart';
import '../basenavigator.dart';
import '../models/my_doctor.dart';

class PrescriptionView extends StatefulWidget {
  static const String routeName = 'PatientPrescription';

  @override
  State<PrescriptionView> createState() => _PrescriptionViewState();
}

class _PrescriptionViewState
    extends BaseView<PrescriptionView, PrescriptionViewModel>
    implements PrescriptionNavigator {
  late DoctorDataBase doctor;
  Stream<QuerySnapshot<Myprescription>>? myPrescriptionStream;

  @override
  void initState() {
    super.initState();
    DatabaseUtilsMyPrescription.readPrescriptionFromFiresore(doctor.id);
    myPrescriptionStream =
        DatabaseUtilsMyPrescription.getPrescriptionCollection().snapshots();
  }

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
        title: Text('prescription'),
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
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                decoration: BoxDecoration(
                                    color: Color(0xFF2C698D),
                                    borderRadius: BorderRadius.circular(12)),
                              ),
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      //showLoading(context,'Deleting');
                                      // DatabaseUtilsMyPrescription
                                      //     .deleteprescriptiontofirestore(
                                      //         Myprescription(
                                      //             fileUrl: x['fileUrl'],
                                      //             num: x['num']));
                                    },
                                    child: Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 5),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: Icon(
                                        Icons.delete,
                                        size: 25,
                                        color: Color(0xFF2C698D),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ));
                });
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  @override
  PrescriptionViewModel initViewModel() {
    return PrescriptionViewModel();
  }
}

class view extends StatelessWidget {
  PdfViewerController? _pdfViewerController;
  final url;

  view({
    this.url,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF2C698D),
        title: Text("view prescription"),
      ),
      body: SfPdfViewer.network(
        url,
        controller: _pdfViewerController,
      ),
    );
  }
}

class PrescriptionModel {
  final DoctorDataBase doctor;

  PrescriptionModel({required this.doctor});
}
