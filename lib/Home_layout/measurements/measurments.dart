import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grad_project/Home_layout/measurements/measurments_form_viewmodel.dart';
import 'package:grad_project/Home_layout/measurements/measurments_navigator.dart';
import 'package:grad_project/models/my_measurments.dart';
import 'package:provider/provider.dart';
import '../../DatabaseUtils/measurments_database.dart';
import '../home.dart';
import 'package:grad_project/basenavigator.dart';

class Measurments extends StatefulWidget {
  static const String routeName = "Measurements";

  const Measurments({
    super.key,
  });

  @override
  _MeasurmentsState createState() => _MeasurmentsState();
}

class _MeasurmentsState extends BaseView<Measurments, MeasurmentsViewModel>
    with SingleTickerProviderStateMixin
    implements MeasurmentsNavigator {
  final parentDocRef = FirebaseFirestore.instance
      .collection('Patients')
      .doc(FirebaseAuth.instance.currentUser!.uid);
  final subcollectionRef = FirebaseFirestore.instance
      .collection('Patients')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection(Mymeasurments.MEASURMENTS);

  //create variable

  //double currentheight = 100;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  int currentweight = 0;
  int currentheight = 100;
  String? height;
  String? weight;
  var measurementsData;
  String? blood_sugar;
  String? blood_pressure;
  String? newblood_pressure = "";
  TextEditingController bloodpressurecontroller = TextEditingController();
  TextEditingController bloodsugarcontroller = TextEditingController();

  void _addData() {
    subcollectionRef.add({
      'blood_pressure': bloodpressurecontroller.text,
      "blood_sugar": bloodsugarcontroller.text,
      'weight': currentweight,
      "height": currentheight
    });
  }

//   String? height="";
// String? weight="";

  Future _updateheight() async {
    await FirebaseFirestore.instance
        .collection(Mymeasurments.MEASURMENTS)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({"height": currentheight});
  }

  Future _updateweight() async {
    await FirebaseFirestore.instance
        .collection(Mymeasurments.MEASURMENTS)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({"weight": currentweight});
  }

  // Future _updatebloodpressure () async
  // {
  //   await FirebaseFirestore.instance.collection(Mymeasurments.MEASURMENTS).
  //   doc(FirebaseAuth.instance.currentUser!.uid)
  //       .update({
  //     "blood_pressure": newblood_pressure
  //   });}

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.navigator = this;
    GetMeasurementsFromDatabase();
    getMeasurementsFromDataase().then((value) {
      bloodpressurecontroller.text = value.blood_pressure;
      bloodsugarcontroller.text = value.blood_sugar;
    });
  }

  Future GetMeasurementsFromDatabase() async {
    Mymeasurments? measurements =
        await DatabaseUtilsMeasurments.readMeasurementsFromFiresore(
            FirebaseAuth.instance.currentUser!.uid);
    if (measurements != null) {
      setState(() {
        height = measurements.height;
        weight = measurements.weight;
        blood_pressure = measurements.blood_pressure;
        blood_sugar = measurements.blood_sugar;
      });
    }
  }

  Future<Mymeasurments> getMeasurementsFromDataase() async {
    var docs = await DatabaseUtilsMeasurments.getMeasurmentsCollection().get();
    Mymeasurments? measurements;
    if (docs.docs.isNotEmpty) {
      measurements = docs.docs[0].data();
    }
    if (measurements != null) {
      setState(() {
        measurementsData = measurements;
      });
      return measurements;
    } else {
      return Mymeasurments.notFound();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => viewModel,
        child: Scaffold(
            appBar: AppBar(
              toolbarHeight: 90,
              backgroundColor: Color(0xFF2C698D),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(25),
                ),
              ),
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
              title: Text(
                'Measurements',
                style: TextStyle(fontSize: 30),
              ),
              centerTitle: true,
              actions: [
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith(
                            (states) => Color(0xFF22C698D))),
                    onPressed: () {
                      setState(() {
                        // _addData();
                        ValidateForm();
                        // _updateheight();
                        //_updatebloodpressure();
                      });
                    },
                    child: Icon(
                      Icons.done,
                      color: Colors.black,
                      size: 30,
                    )),
              ],
            ),
            body: Form(
              key: formKey,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.only(left: 20, top: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Enter your height:",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: Colors.black),
                      ),
                      SizedBox(height: 10),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              currentheight.toString(),
                              style: TextStyle(fontSize: 25),
                            ),
                            SizedBox(width: 5),
                            Text(
                              "cm",
                              style: TextStyle(fontSize: 23),
                            ),
                          ]),
                      Stack(alignment: Alignment.topRight, children: [
                        Slider(
                            value: (currentheight ?? 100).toDouble(),
                            min: 100,
                            max: 200,
                            divisions: 100,
                            label: currentheight.toString(),
                            thumbColor: Color(0xFF53A8CC),
                            activeColor: Color(0xFF2C698D),
                            inactiveColor: Colors.grey,
                            // onChanged: ((value) {
                            //   setState(() {
                            //    currentheight = value;
                            //   });
                            // }
                            onChanged: (val) =>
                                setState(() => currentheight = val.round())),
                        Image.asset(
                          'assets/images/height.jpg',
                          scale: 3,
                        )
                      ]),
                      Divider(
                        color: Colors.black,
                        thickness: 1.5,
                        indent: 10,
                        endIndent: 10,
                      ),
                      SizedBox(height: 15),
                      Row(children: [
                        Text(
                          "Enter your weight:",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              color: Colors.black),
                        ),
                        SizedBox(width: 15),
                        Container(
                            width: 160,
                            height: 35,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xFF2C698D)),
                            child: Row(
                              children: [
                                RawMaterialButton(
                                  onPressed: () {
                                    setState(() {
                                      if (currentweight > 0) currentweight--;
                                      print(currentweight);
                                    });
                                  },
                                  child: Icon(Icons.remove),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  fillColor: Colors.white,
                                  constraints:
                                      BoxConstraints.tightFor(width: 25),
                                ),
                                TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    '$currentweight',
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  ),
                                ),
                                RawMaterialButton(
                                  onPressed: () {
                                    setState(() {
                                      currentweight = currentweight + 5;
                                    });
                                  },
                                  child: Icon(Icons.add),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  fillColor: Colors.white,
                                  constraints:
                                      BoxConstraints.tightFor(width: 25),
                                ),
                              ],
                            )),
                      ]),
                      SizedBox(height: 5),
                      Image.asset(
                        'assets/images/weight.jpg',
                        scale: 1.5,
                      ),
                      Divider(
                        color: Colors.black,
                        thickness: 1.5,
                        indent: 10,
                        endIndent: 10,
                      ),
                      SizedBox(height: 15),
                      Text(
                        "Enter your blood pressure:",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: Colors.black),
                      ),
                      SizedBox(height: 13),
                      Center(
                        child: Container(
                            width: 160,
                            height: 38,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xFF2C698D)),
                            child: TextFormField(
                              controller: bloodpressurecontroller,
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              onChanged: (value) {
                                setState(() {
                                  newblood_pressure = value;
                                });
                              },
                              cursorColor: Colors.white,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                              decoration: InputDecoration(
                                // suffixText: 'mmHg',
                                hintText: 'BP in mmHg',
                                hintStyle: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            )),
                      ),
                      SizedBox(height: 10),
                      Divider(
                        color: Colors.black,
                        thickness: 1.5,
                        indent: 10,
                        endIndent: 10,
                      ),
                      SizedBox(height: 15),
                      Text(
                        "Enter your blood sugar:",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: Colors.black),
                      ),
                      Row(
                        children: [
                          Container(
                            width: 160,
                            height: 38,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xFF2C698D)),
                            child: TextFormField(
                              controller: bloodsugarcontroller,
                              textAlign: TextAlign.center,
                              cursorColor: Colors.white,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                              decoration: InputDecoration(
                                // suffixText: 'mmHg',
                                hintText: 'BS in mg/DL',
                                hintStyle: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 21,
                          ),
                          // Image.asset(
                          //   'assets/images/blood.jpg',
                          //   width: 205,
                          // ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )));
  }

  @override
  MeasurmentsViewModel initViewModel() {
    return MeasurmentsViewModel();
  }

  Future<void> ValidateForm() async {
    if (formKey.currentState!.validate()) {
      await viewModel.AddOrUpdateMeasurmentsToDB(
          bloodpressurecontroller.text,
          bloodpressurecontroller.text,
          currentheight.toString(),
          currentweight.toString());
    }
  }
}
