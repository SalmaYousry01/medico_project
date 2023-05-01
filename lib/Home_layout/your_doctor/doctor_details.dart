import 'package:flutter/material.dart';
import 'package:grad_project/Home_layout/your_doctor/modell.dart';



class DoctorDetailsPage extends StatelessWidget {
  final Doctor doctor;

  DoctorDetailsPage({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Color(0xFF2C698D),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40),
                        topLeft: Radius.circular(40),
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15)),
                    child: Center(
                      child: Image.asset(
                        doctor.image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 30,),
                  Padding(
                    padding: const EdgeInsets.only(left: 40,),
                    child: Container(
                      margin: EdgeInsets.all(0.4),
                      width: 300,
                      height: 120,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(width: 1,color:Color(0xFF2C698D) )
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: Text(
                              '${doctor.name}',
                              style: TextStyle(color: Colors.black, fontSize: 29),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: Text(
                              'Field: ${doctor.use}',
                              style: TextStyle(color: Colors.black, fontSize: 29),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30,),
              Text(
                'Clinic',
                style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10,),
              Text(
                'Address: ${doctor.Address}',
                style: TextStyle(
                    fontSize: 22,
                    color: Colors.black),
              ),
              SizedBox(height: 10,),

              Text(
                'PhoneNumber: ${doctor.PhoneNumber}',
                style: TextStyle(
                    fontSize: 22,
                    color: Colors.black),
              ),
              SizedBox(height: 10,),

              Text(
                'Availability: ${doctor.Availability}',
                style: TextStyle(
                    fontSize: 22,
                    color: Colors.black),
              ),
              SizedBox(height: 10,),


              Text(
                'Fee: ${doctor.Fee}',
                style: TextStyle(
                    fontSize: 22,
                    color: Colors.black),
              ),
              SizedBox(height: 10,),

              Text(
                'About: ${doctor.About}',
                style: TextStyle(
                    fontSize: 22,

                    color: Colors.black),
              ),


            ],
          ),
        ),
      ),
    );
  }
}