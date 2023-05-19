import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grad_project/view_only_patient/view_only_patient_view.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../DatabaseUtils/test_database.dart';
import '../../Home_layout/test/test_navigator.dart';
import '../../Home_layout/test/test_viewmodel.dart';
import '../../basenavigator.dart';
import '../../models/my_test.dart';

class TestView extends StatefulWidget {
  static const String routeName = 'TestView';

  @override
  State<TestView> createState() => _TestViewState();
}

class _TestViewState extends BaseView<TestView, TestViewModel>
    implements TestNavigator {
  Stream<QuerySnapshot<MyTest>>? myTestStream;

  @override
  void initState() {
    super.initState();
    myTestStream = DatabaseUtilsTest.getTestCollection().snapshots();
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
        title: Text('Tests'),
        centerTitle: true,
        // leading: GestureDetector(
        //   onTap: () {
        //     Navigator.pushReplacement(context,
        //         MaterialPageRoute(builder: (_) => ViewOnlyPatientView()));
        //   },
        //   child: Icon(
        //     Icons.arrow_back,
        //     size: 30,
        //     color: Colors.black,
        //   ),
        // ),
      ),
      body: StreamBuilder(
        stream: myTestStream,
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
  TestViewModel initViewModel() {
    return TestViewModel();
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
        title: Text("view test"),
      ),
      body: SfPdfViewer.network(
        url,
        controller: _pdfViewerController,
      ),
    );
  }
}
