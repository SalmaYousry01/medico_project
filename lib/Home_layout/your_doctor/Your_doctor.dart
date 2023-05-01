import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:grad_project/Home_layout/your_doctor/doctor_controller.dart';
import 'package:grad_project/Home_layout/your_doctor/doctor_details.dart';
import 'package:grad_project/Home_layout/your_doctor/modell.dart';


class YourDoctors extends StatefulWidget {
  YourDoctors({Key? key}) : super(key: key);

  @override
  State<YourDoctors> createState() => _YourDoctorsState();
}

class _YourDoctorsState extends State<YourDoctors> {
  final DoctorController controller = Get.put(DoctorController());

  @override
  Widget build(BuildContext context) {
    // List<Doctor> Add=[];

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Color(0xFF2C698D),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        title: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 75,
                ),
                Center(
                  child: Text(
                    'Doctors',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
                  ),
                ),
              ],
            ),
          ],
        ),
        leading: Icon(
          Icons.arrow_back,
          size: 30,
        ),
      ),
      body: ListView.builder(
          itemCount: controller.doctors.length,
          itemBuilder: (BuildContext context, int index) {
            return YourDoctortWidget(
              index: index,
              controller: controller,
              doctor: controller.doctors.keys.toList()[index],
            );
          }),
    );
  }
}

class YourDoctortWidget extends StatefulWidget {
  YourDoctortWidget(
      {Key? key,
      required this.controller,
      required this.doctor,
      required this.index})
      : super(key: key);
  final DoctorController controller;
  final Doctor doctor;
  final int index;

  @override
  State<YourDoctortWidget> createState() => _YourDoctortWidgetState();
}

class _YourDoctortWidgetState extends State<YourDoctortWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 15.00, right: 15.00),
        child: ListTile(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => DoctorDetailsPage(
                      doctor: widget.doctor,
                    )));
          },
          leading: Container(
              width: 50, height: 150, child: Image.asset(widget.doctor.image)),
          title: Text(
            widget.doctor.name,
            style: const TextStyle(color: Colors.black, fontSize: 18),
          ),
          subtitle: Text(
            " ${(widget.doctor.use.toString())}",
            style: const TextStyle(color: Colors.black87, fontSize: 14),
          ),
          trailing: IconButton(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            padding: EdgeInsets.zero,
            onPressed: () {
              setState(() {
                widget.controller.removeDoctor(widget.doctor);
              });
              // doctorController.addDoctor(Doctor.items);
              // controller.removeDoctor(doctor);
              // Get.to(() => YourDoctors());
            },
            icon: CircleAvatar(
              backgroundColor: Color(0xFF2C698D),
              radius: 10.0,
              child: Icon(
                Icons.remove,
                color: Colors.white,
                size: 20.0,
              ),
            ),
          ),
        ));
  }
}
