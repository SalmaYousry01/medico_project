// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:grad_project/doctor_layout/all_patients/single_patient_widget.dart';
// import '../../DatabaseUtils/clinic_database.dart';
// import '../../Home_layout/your_doctor/single_doctor_clinic_profile.dart';
// import '../../models/my_patient.dart';
// import 'patient_controller.dart';
//
// class YourPatients extends StatelessWidget {
//   final PatientController controller = Get.find();
//   static const String routeName = "YourPatients";
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           toolbarHeight: 100,
//           backgroundColor: Color(0xFF2C698D),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.vertical(
//               bottom: Radius.circular(30),
//             ),
//           ),
//           title: Text('Patients'),
//           centerTitle: true,
//         ),
//         body: ListView.builder(
//           itemCount: controller.patients.length,
//           itemBuilder: (BuildContext context, int index) {
//             return YourPatientWidget(
//                 controller: controller,
//                 patient: controller.patients.keys.toList()[index],
//                 index: index);
//           },
//         ));
//   }
// }
//
// class YourPatientWidget extends StatelessWidget {
//   final PatientController controller;
//   final MyPatient patient;
//   final int index;
//
//   YourPatientWidget(
//       {required this.controller, required this.patient, required this.index});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: ListTile(
//         onTap: () {
//           DatabaseUtilsClinic.getDoctorClinicsCollectionFromId(patient.id).then(
//               (clinic) => Navigator.pushNamed(
//                   context, SingleDoctorClinicProfile.routeName,
//                   arguments: PatientModel(patient: patient)));
//         },
//         leading: CircleAvatar(backgroundImage: NetworkImage(patient.image)),
//         title: Text(patient.fullname),
//         subtitle: Text(patient.email),
//         trailing: IconButton(
//           highlightColor: Colors.transparent,
//           splashColor: Color.fromARGB(0, 63, 36, 36),
//           padding: EdgeInsets.zero,
//           onPressed: () {
//             controller.removePatients(patient);
//             // controller.addDoctor();
//             // widget.doctorController.addDoctor(widget.doctor);
//             // Get.to(() => YourDoctors());
//           },
//           icon: CircleAvatar(
//             backgroundColor: Color(0xFF2C698D),
//             radius: 10.0,
//             child: Icon(
//               Icons.delete,
//               color: Colors.white,
//               size: 15.0,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
