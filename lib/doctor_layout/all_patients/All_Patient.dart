import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:grad_project/doctor_layout/all_patients/Allpatient_viewmodel.dart';
import 'package:grad_project/doctor_layout/all_patients/all_navP.dart';
import 'package:grad_project/doctor_layout/all_patients/sea.dart';
import 'package:grad_project/models/my_patient.dart';
import 'package:grad_project/view_only_patient/view_only_patient_view.dart';
import '../../DatabaseUtils/doctor_database.dart';
import '../../basenavigator.dart';

class AllPatient extends StatefulWidget {
  static const String routeName = 'Allpatient';

  @override
  State<AllPatient> createState() => _AllPatientState();
}

class _AllPatientState extends BaseView<AllPatient, AllPatientViewModel>
    implements AllPatientNavigator {
  late Stream<QuerySnapshot<MyPatient>> patientsStream;

  void initState() {
    super.initState();
    viewModel.navigator = this;
    patientsStream = DatabaseUtilsdoctor.getDoctorPatientsCollectionAsStream();
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
          title: Text('Patients'),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  showSearch<Object?>(context: context, delegate: sea());
                },
                icon: Icon(Icons.search))
          ],
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: patientsStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text('something went wrong'));
              } else {
                List<MyPatient> myPatients = snapshot.data!.docs
                    .map((e) => e.data() as MyPatient)
                    .toList();
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                        padding:
                            const EdgeInsets.only(left: 15.00, right: 15.00),
                        child: ListTile(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => ViewOnlyPatientView(
                                      patient: myPatients[index],
                                    )));
                          },
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                                "${snapshot.data?.docs[index]['image']}"),
                          ),
                          title:
                              Text("${snapshot.data?.docs[index]['fullname']}"),
                          subtitle:
                              Text("${snapshot.data?.docs[index]['username']}"),
                        ));
                  },
                );
              }
            }));
  }

  @override
  void goToHomePage(MyPatient patient) {
    // Provider.of<MyProvider>(context, listen: false);
    // Navigator.pushReplacementNamed(context, home.routeName, arguments: true);
  }

  @override
  AllPatientViewModel initViewModel() {
    return AllPatientViewModel();
  }
}
