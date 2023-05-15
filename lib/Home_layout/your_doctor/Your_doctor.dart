import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:grad_project/Home_layout/your_doctor/single_doctor_widget_without_plus.dart';
import 'package:grad_project/Home_layout/your_doctor/your_doctor_viewmodel.dart';
import 'package:grad_project/basenavigator.dart';
import 'package:grad_project/models/my_doctor.dart';
import 'package:provider/provider.dart';
import '../../DatabaseUtils/yourDoctor_database.dart';
import '../../Profile/clinicProfile_navigator.dart';
import 'doctor_controller.dart';

class YourDoctors extends StatefulWidget {
  static const String routeName = "YourDoctors";

  @override
  _YourDoctorsState createState() => _YourDoctorsState();
}

class _YourDoctorsState extends BaseView<YourDoctors, YourDoctorViewModel>
    with SingleTickerProviderStateMixin
    implements clinicProfileNavigator {
  final DoctorController controller = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.navigator = this;
    viewModel.removeDoctors();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 100,
          backgroundColor: Color(0xFF2C698D),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
          title: Text('Doctors'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: FutureBuilder<QuerySnapshot<DoctorDataBase>>(
                    future: DatabaseUtilsDoctorPatient.getdoctortofirestore(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return Center(child: Text('something went wrong'));
                      }
                      var yourdoctor = snapshot.data?.docs
                              .map((docs) => docs.data())
                              .toList() ??
                          [];
                      return Expanded(
                        child: ListView.builder(
                            itemCount: yourdoctor.length,
                            itemBuilder: (context, Index) {
                              return SingleDoctorWithoutPlus(yourdoctor[Index]);
                            }),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  YourDoctorViewModel initViewModel() {
    return YourDoctorViewModel();
  }
}
