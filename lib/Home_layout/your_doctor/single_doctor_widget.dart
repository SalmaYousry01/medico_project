import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:grad_project/DatabaseUtils/Patient_Database.dart';
import 'package:grad_project/Home_layout/your_doctor/single_doctor_clinic_profile.dart';
import '../../DatabaseUtils/yourDoctor_database.dart';
import '../../models/my_clinic.dart';
import '../../models/my_doctor.dart';
import 'package:grad_project/DatabaseUtils/clinic_database.dart';
import 'doctor_controller.dart';

class SingleDoctortWidget extends StatelessWidget {
  final controller = Get.put(DoctorController());
  DoctorDataBase doctor;

  // MyPatient patient;




  SingleDoctortWidget(this.doctor);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        onTap: () {

          DatabaseUtilsClinic.getDoctorClinicsCollectionFromId(doctor.id).then(
                  (clinic) => Navigator.pushNamed(
                  context, SingleDoctorClinicProfile.routeName,
                  arguments:
                  DoctorClinicModel(doctor: doctor, clinic: clinic!)));
        },
        leading: CircleAvatar(backgroundImage: NetworkImage(doctor.image)),
        title: Text(doctor.fullName),
        subtitle: Text(doctor.Field),
        trailing: IconButton(
          highlightColor: Colors.transparent,
          splashColor: Color.fromARGB(0, 63, 36, 36),
          padding: EdgeInsets.zero,
          onPressed: () async {
            // controller.addOrRemoveDoctor(doctor);
            // controller.addDoctor(doctor);



          },
          icon: CircleAvatar(
            backgroundColor: Color(0xFF2C698D),
            radius: 10.0,
            child: GestureDetector(
              onTap: (){
                // QuickAlert.show(
                //   context: context,
                //   type: QuickAlertType.confirm,
                //   title: "Notice",
                //   text: "if you pressed okay this doctor will be able to view all your medical data");
                showDialog(
                    context: context,
                    builder: (BuildContext context){
                      return AlertDialog(
                        title: Text("Notice",),
                        content: Text( "if you pressed okay this doctor will be able to view all your medical data"),
                        actions: [

                          // IconButton(
                          //     color:Colors.white ,
                          //     onPressed: (){
                          //       Navigator.pop(context);
                          //     }
                          //     , icon: Icon(Icons.cancel_outlined, color: Color(0xFF22C698D),)),
                          TextButton(onPressed: (){
                            Navigator.pop(context);
                          },
                              child: Text("Cancel",style: TextStyle(color: Color(0xFF2C698D),),)),

                          TextButton(
                              onPressed: (){


                                DoctorDataBase yourdoctor = DoctorDataBase(
                                    Field: doctor.Field,
                                    email: doctor.email,
                                    fullName: doctor.fullName,
                                    image: doctor.image,
                                    id: doctor.id,
                                    nationalID: doctor.nationalID,
                                    phoneNumber: doctor.phoneNumber);
                                Future.wait([
                                  DatabaseUtilsDoctorPatient.addPatientDoctorToFirestore(yourdoctor),
                                  DatabaseUtilspatient.readPateintFromFiresore(FirebaseAuth.instance.currentUser!.uid).then((value) {
                                    print(">>>>>>>>>>>>>>>>>>> Doctor ID : ${yourdoctor.id}");
                                    DatabaseUtilsDoctorPatient.addPetientToDoctorFirestore(yourdoctor, value!);
                                    print("Success!!!");
                                  }
                                  ),
                                ],);
                                Navigator.pop(context);
                              },
                              // color: Color(0xFF22C698D),
                              //icon: Icon(Icons.done)
                              child: Text("Confirm",style: TextStyle( color: Color(0xFF2C698D),),)
                          ),


                        ],
                      );
                    });
              },
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: 20.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DoctorClinicModel {
  final DoctorDataBase doctor;
  final MyClinic clinic;

  DoctorClinicModel({required this.doctor, required this.clinic});
}
