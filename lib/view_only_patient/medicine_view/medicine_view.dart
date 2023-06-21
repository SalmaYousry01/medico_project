import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grad_project/DatabaseUtils/doctor_database.dart';
import '../../Home_layout/medicine/medicine_items.dart';
import '../../models/my_medicine.dart';
import 'medicine_container.dart';

class MedicineView extends StatefulWidget {
  @override
  State<MedicineView> createState() => MedicineViewState();
  static const String routeName = 'medicineview';

  String? patientId;

  MedicineView([this.patientId]);
}

class MedicineViewState extends State<MedicineView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(
        //     onPressed: () {
        //       Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //           builder: (context) => ViewOnlyPatientView(),
        //         ),
        //       );
        //     },
        //     icon: Icon(Icons.arrow_back)),
        title: Text('Medicine'),
        centerTitle: true,
        backgroundColor: Color(0xFF2C698D),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/welcome page.png"),
                fit: BoxFit.cover)),
        child: FutureBuilder<QuerySnapshot<Mymedicine>>(
            future: DatabaseUtilsdoctor.getPatientMedicines(widget.patientId!),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text('something went wrong'));
              }
              var medicine =
                  snapshot.data?.docs.map((docs) => docs.data()).toList() ?? [];
              if (medicine.isEmpty) {
                return const Center(
                  child: Text("This patient has no medicine"),
                );
              }
              return ListView.builder(
                  itemCount: medicine.length,
                  itemBuilder: (context, Index) {
                    return MedicineContainer(medicine[Index]);
                  });
            }),
      ),
    );
  }


// @override
// MedicineViewOnlyViewModel initViewModel() {
//   return MedicineViewOnlyViewModel();
// }
}
