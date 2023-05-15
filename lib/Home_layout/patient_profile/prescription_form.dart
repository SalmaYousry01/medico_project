import 'package:flutter/material.dart';
import 'package:grad_project/Home_layout/home.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class DoctorPrescription extends StatefulWidget {
  @override
  DoctorPrescriptionState createState() => DoctorPrescriptionState();
}

class DoctorPrescriptionState extends State<DoctorPrescription> {
  TextEditingController _medicineEditingController = TextEditingController();
  TextEditingController _testEditingController = TextEditingController();

  bool _showList = false;

  List<String> medicine_list = [];
  String? medicine;
  String? tests;
  List<String> tests_list = [];
  final List<String> dosage_list = ["0.25", "0.5", "1", "1.5", "2", "2.5", "3"];
  List<String> empty_dosage_list = [];
  String? dosage;
  final List<String> time_list = [
    "Every 4 hours",
    "Every 6 hours",
    "Every 8 hours",
    "Every 12 hours"
  ];
  List<String> empty_time_list = [];
  String? time;

  medicine_alert() {
    QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: "please add medicine",
        text: "error");
  }

  dosage_alert() {
    QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: "please add dosage",
        text: "error");
  }

  time_alert() {
    QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: "please add dosage",
        text: "error");
  }

  @override
  void dispose() {
    _medicineEditingController.dispose();
    _testEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: (Colors.white),
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => home()));
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 30,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/prescription.png"),
                fit: BoxFit.fill)),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16, top: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0),
                  borderRadius: BorderRadius.circular(10),
                  //  border: Border.all(color: Color(0xFF22C698D) )
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                        heightFactor: 0,
                        child: Text(
                          'Prescription Form',
                          style: TextStyle(fontSize: 20),
                        )),

                    SizedBox(
                      height: 5,
                    ),

                    Padding(
                      padding:
                          const EdgeInsets.only(top: 8, left: 8.0, bottom: 3),
                      child: Row(
                        children: [
                          Icon(Icons.badge_rounded),
                          Text(" Clinic Name"),
                          SizedBox(
                            width: 130,
                          ),
                          Text("Doctor Name")
                        ],
                      ),
                    ),

                    Padding(
                      padding:
                          const EdgeInsets.only(top: 3, left: 8.0, bottom: 3),
                      child: Row(
                        children: [
                          Icon(Icons.phone),
                          Text(" Phone Number"),
                          SizedBox(
                            width: 115,
                          ),
                          Text("Doctor Major")
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Text(
                        "Medicine Name",
                        style: TextStyle(fontSize: 17.5),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 16.0,
                        top: 5,
                        bottom: 5,
                      ),
                      child: TextFormField(
                        controller: _medicineEditingController,
                        decoration: InputDecoration(
                            hintText: 'Enter a value',
                            labelText: 'Medicine name',
                            border: OutlineInputBorder()),
                        // validator: ((Text) {
                        //   if (Text!.trim() == '') {
                        //     return "please enter medicine";
                        //   }
                        // }),
                        // onFieldSubmitted: (String value) {
                        //   print(value);
                        // },
                      ),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Row(
                        children: [
                          Text(
                            'Dosage  ',
                            style: TextStyle(fontSize: 18),
                          ),
                          Container(
                            height: 30,
                            width: 58,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.black.withOpacity(0.2))),
                            child: DropdownButton<String>(
                              value: dosage,
                              onChanged: (value) {
                                setState(() {
                                  dosage = value;
                                });
                              },
                              // onChanged: (value) {
                              //   if (dosage == null) {
                              //     return warning();
                              //   } else {
                              //     dosage = value;
                              //   }
                              //   setState(() {});
                              // },

                              items: dosage_list
                                  .map<DropdownMenuItem<String>>(
                                      (String value) =>
                                          DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          ))
                                  .toList(),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "Time   ",
                            style: TextStyle(fontSize: 18),
                          ),
                          Container(
                            height: 30,
                            width: 120,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.black.withOpacity(0.2))),
                            child: DropdownButton<String>(
                              value: time,
                              onChanged: (value) {
                                setState(() {
                                  time = value;
                                });
                              },
                              items: time_list
                                  .map<DropdownMenuItem<String>>(
                                      (String value) =>
                                          DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          ))
                                  .toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 16.0,
                        top: 3,
                        bottom: 3,
                      ),
                      child: Text(
                        "Required Tests",
                        style: TextStyle(fontSize: 17.5),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 16.0,
                        top: 3,
                        bottom: 3,
                      ),
                      child: TextFormField(
                        controller: _testEditingController,
                        decoration: InputDecoration(
                            hintText: 'Enter a value',
                            labelText: 'Required Tests',
                            border: OutlineInputBorder()),
                      ),
                    ),

                    Padding(
                        padding: const EdgeInsets.only(left: 16.0, bottom: 3),
                        child: Row(
                          children: [
                            Flexible(
                              child: TextField(
                                decoration: InputDecoration(
                                  labelText: 'Date',
                                ),
                              ),
                            ),
                            SizedBox(width: 16),
                            Flexible(
                              child: TextField(
                                decoration: InputDecoration(
                                  labelText: 'Signature',
                                ),
                              ),
                            ),
                          ],
                        )),
                    //SizedBox(height: 8,),
                    // Padding(
                    //   padding: const EdgeInsets.only(top: 10.0,left: 50,bottom: 10),
                    //   child: Row(children: [
                    //     Text('DATE'),
                    //     SizedBox(width: 180,),
                    //     Text('SIGNATURE')
                    //   ],),
                    // ),

                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                          Color(0xFF22C698D),
                        )),
                        onPressed: () {
                          setState(() {
                            if (_medicineEditingController.text.isNotEmpty) {
                              medicine_list
                                  .add(_medicineEditingController.text);
                              _medicineEditingController.clear();
                            } else {
                              return medicine_alert();
                            }
                            if (dosage != null) {
                              empty_dosage_list.add(dosage!);
                            } else {
                              return dosage_alert();
                            }
                            if (time != null) {
                              empty_time_list.add(time!);
                            } else {
                              return time_alert();
                            }
                            if (_testEditingController.text.isNotEmpty) {
                              tests_list.add(_testEditingController.text);
                              _testEditingController.clear();
                            }
                            // else{
                            //   return null;
                            // }

                            _showList = true;
                          });
                        },
                        child: Text('Submit Prescription'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: _showList,
              child: Expanded(
                child: Container(
                  //margin: const EdgeInsets.all(8.0),
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    //border: Border.all(),
                    color: Colors.white.withOpacity(0),
                    borderRadius: BorderRadius.circular(8.0),
                    // image: DecorationImage(
                    //     fit: BoxFit.cover,
                    //     image:AssetImage("assets/images/prescription.png") )
                  ),
                  child: ListView.builder(
                    itemCount: medicine_list.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          ListTile(
                            title: Text(medicine_list[index]),
                            subtitle: Text(empty_dosage_list[index]),
                            trailing: Text(empty_time_list[index]),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
            Visibility(
              visible: _showList,
              child: Expanded(
                child: Container(
                  //margin: const EdgeInsets.all(8.0),
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    //border: Border.all(),
                    color: Colors.white.withOpacity(0),
                    borderRadius: BorderRadius.circular(8.0),
                    // image: DecorationImage(
                    //     fit: BoxFit.cover,
                    //     image:AssetImage("assets/images/prescription.png") )
                  ),
                  child: ListView.builder(
                    itemCount: tests_list.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text("Required tests",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        subtitle: Text(
                          tests_list[index],
                          style: TextStyle(fontSize: 18),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
