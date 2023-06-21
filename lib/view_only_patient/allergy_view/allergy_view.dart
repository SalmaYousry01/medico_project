import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grad_project/models/my_patient.dart';
import 'package:grad_project/view_only_patient/allergy_view/allergies_navigator.dart';
import 'package:grad_project/view_only_patient/view_only_patient_view.dart';
import '../../DatabaseUtils/allergy_database.dart';
import '../../DatabaseUtils/doctor_database.dart';
import '../../models/my_allergies.dart';
import 'allergies_viewmodel.dart';
import 'package:grad_project/basenavigator.dart';

import 'allergy_container.dart';

class AllergyView extends StatefulWidget {
  static const String routeName = 'allergyview';
  String? patientId;

  AllergyView([this.patientId]);

  @override
  State<AllergyView> createState() => _AllergyViewState();
}

class _AllergyViewState extends BaseView<AllergyView, AllergiesViewModel>
    with SingleTickerProviderStateMixin
    implements AllergiesNavigator {
  var allergyData;
  TextEditingController skinController = TextEditingController();
  TextEditingController nasalController = TextEditingController();
  TextEditingController foodController = TextEditingController();
  TextEditingController chestController = TextEditingController();
  TextEditingController substanceController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.navigator = this;
    _getDataFromDatabase();
    getAllergyFromDatabase().then((value) {
      skinController.text = value.skin;
      nasalController.text = value.nasal;
      foodController.text = value.food;
      chestController.text = value.chest;
      substanceController.text = value.substance;
    });
  }

  String? chest = '';
  String? nasal = '';
  String? substance = '';
  String? skin = '';
  String? food = '';

  // Future GetDataFromDatabase() async {
  //   DoctorDataBase? doctor = await DatabaseUtilsdoctor.readUserFromFiresore(
  //       FirebaseAuth.instance.currentUser!.uid);
  //   if (doctor != null) {
  //     setState(() {
  //       name = doctor.fullName;
  //       field = doctor.Field;
  //       image = doctor.image;
  //     });
  //   }
  // }

  Future _getDataFromDatabase() async {
    await FirebaseFirestore.instance
        .collection(MyPatient.COLLECTION_NAME)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection(MyAllergy.COLLECTION_NAME)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((snapshot) async {
      //means if data exists
      if (snapshot.exists) {
        setState(() {
          chest = snapshot.data()!["chest"];
          nasal = snapshot.data()!["nasal"];
          substance = snapshot.data()!["substance"];
          skin = snapshot.data()!["skin"];
          food = snapshot.data()!["food"];
        });
      }
    });
  }

  Future<MyAllergy> getAllergyFromDatabase() async {
    var docs = await DatabaseUtilsAllergy.getAllergyCollection().get();
    MyAllergy? allergy;
    if (docs.docs.isNotEmpty) {
      allergy = docs.docs[0].data();
    }
    if (allergy != null) {
      setState(() {
        allergyData = allergy;
      });
      return allergy;
    } else {
      return MyAllergy.notFound();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 10),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ViewOnlyPatientView(),
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      size: 28,
                    ),
                  ),
                  Text(
                    " Allergies",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2C698D)),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                ],
              ),
            ),
            const Divider(
              color: Color(0xFF216B98),
              height: 37,
            ),
            Container(
              child: FutureBuilder<QuerySnapshot<MyAllergy>>(
                  future:
                      DatabaseUtilsdoctor.getPatientAllegry(widget.patientId!),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text('Something went wrong'));
                    }
                    var allergy = snapshot.data?.docs
                            .map((docs) => docs.data())
                            .toList() ??
                        [];
                    if (allergy.isEmpty) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 300),
                        child: const Center(
                          child: Text(
                            "This patient has no allergy",
                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Color(0xFF2C698D)),

                          ),
                        ),
                      );
                    }
                    return Expanded(
                      child: ListView.builder(
                          itemCount: allergy.length,
                          itemBuilder: (context, Index) {
                            return Allergycontainer(allergy[Index]);
                          }),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }

  @override
  AllergiesViewModel initViewModel() {
    return AllergiesViewModel();
  }
}
