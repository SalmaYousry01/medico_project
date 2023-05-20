import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grad_project/Home_layout/prescription/pateint_uploaded_prescriptions/patient_prescreption.dart';
import '../../DatabaseUtils/exported_prescription_database.dart';
import '../../models/my_prescription__exported_pdf.dart';
import 'prescription_exported_pdfs/doctor_uploaded_prescription.dart';

class Prescreption_navbar extends StatefulWidget {

  static const String routeName = 'Prescription_navbar';

  @override
  State<Prescreption_navbar> createState() => Prescreption_navbarState();
}

class Prescreption_navbarState extends State<Prescreption_navbar> {
  int currentindex = 0;
  late Stream<QuerySnapshot<Myprescpdf>> myPrescriptionStream;

  @override
  void initState() {
    super.initState();
    myPrescriptionStream =
        DatabaseUtilsMyprescpdf.getPrescCollection().snapshots();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> tabs = [
      PatientPrescription(),
      PrescListPage(myPrescriptionStream: myPrescriptionStream),
    ];

    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        notchMargin: 8,
        shape: CircularNotchedRectangle(),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          currentIndex: currentindex,
          onTap: (index) {
            setState(() {
              currentindex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.people_alt_rounded,
                  size: 30,
                ),
                label: 'Patient Prescription'),
            //  BottomNavigationBarItem(icon: Icon(Icons.person, size: 30), label: 'Doctor Prescription'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                  size: 30,
                ),
                label: 'Prescription'),
          ],
        ),
      ),
      body: tabs[currentindex],
    );
  }
}
