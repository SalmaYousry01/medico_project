import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grad_project/DatabaseUtils/allergy_database.dart';
import 'package:grad_project/Home_layout/Allergies/chooose.dart';
import 'package:grad_project/Home_layout/allergies/allergy.items.dart';
import 'package:grad_project/Home_layout/allergies/allergy_viewmodel.dart';
import 'package:grad_project/models/my_allergies.dart';

class allergy1 extends StatefulWidget {
  @override
  State<allergy1> createState() => _allergy1State();
  static const String routeName = 'allergy1';
}

class _allergy1State extends State<allergy1> {
  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // IconButton(
            //     onPressed: () {
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //           builder: (context) => chooose(),
            //         ),
            //       );
            //     },
            //     icon: Icon(Icons.arrow_back)),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 10),
              child: Row(
                children: [
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
                  IconButton(
                      icon: Icon(
                        Icons.add_circle,
                        size: 35,
                      ),
                      onPressed: () {
                        _settingModalBottomSheet(context);
                      },
                      color: Color(
                        0xFF2C698D,
                      )),
                ],
              ),
            ),
            const Divider(
              color: Color(0xFF216B98),
              height: 37,
            ),
            Container(
              child: FutureBuilder<QuerySnapshot<MyAllergy>>(
                  future: getAllergytofirestore(),
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
                    return Expanded(
                      child: ListView.builder(
                          itemCount: allergy.length,
                          itemBuilder: (context, Index) {
                            return AllergyItem(allergy[Index]);
                          }),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Widget medicineList(int index) {
    // TextEditingController nameController = TextEditingController();
    // TextEditingController dosageController = TextEditingController();

    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        height: 75,
        child: Center(
          child: Row(
            children: [
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Flexible(
                        child: ListTile(
                          title: Text(
                            food[index],
                            style: TextStyle(
                              fontSize: 20.00,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          subtitle: Text(
                            chest[index],
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          // trailing: IconButton(
                          //     onPressed: () {},
                          //     icon: Image.asset(
                          //       'icons/medicine.time2.png',
                          //       color: Color(
                          //         0xFF2C698D,
                          //       ),
                          //     )),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _settingModalBottomSheet(context) {
    TextEditingController skinController = TextEditingController();
    TextEditingController nasalController = TextEditingController();
    TextEditingController foodController = TextEditingController();
    TextEditingController chestController = TextEditingController();
    TextEditingController substanceController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      elevation: 50,
      isDismissible: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(38),
          topLeft: Radius.circular(38),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      builder: (BuildContext bc) {
        return Padding(
            padding: EdgeInsets.only(left: 25, right: 25),
            child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: (MediaQuery.of(context).size.height),
                    ),
                    child: Padding(
                        padding: EdgeInsets.only(
                          bottom: 250,
                          top: 50,
                        ),
                        child: Column(children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 100),
                                child: IconButton(
                                    icon: Icon(
                                      Icons.arrow_back,
                                      size: 27,
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    }),
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() {
                                      MyAllergy allergy = MyAllergy(
                                        chest: chestController.text,
                                        nasal: nasalController.text,
                                        substance: substanceController.text,
                                        skin: skinController.text,
                                        food: foodController.text,
                                      );
                                      // showLoading(context, 'Saving note');
                                      AddAllergyToFirestore(allergy);
                                      // hideLoading(context);
                                    });

                                    Navigator.pop(context);
                                  }
                                  print(chestController.text);
                                  print(nasalController.text);
                                  print(substanceController.text);
                                  print(skinController.text);
                                  print(foodController.text);
                                },
                                child: Container(
                                  child: Row(
                                    children: [
                                      Text(
                                        "Save",
                                        style: TextStyle(
                                          fontSize: 20.00,
                                          color: Color(0xFF2C698D),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text('Do you have chest allergy?',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF2C698D))),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: TextFormField(
                              controller: chestController,
                              validator: (text) {
                                if (text == '') {
                                  return 'Please Answer';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: (BorderRadius.circular(20))),
                                hintText: ("Chest allergy"),
                                hintStyle: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black45,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              onFieldSubmitted: (String value) {
                                FocusScope.of(context)
                                    .requestFocus(textSecondFocusNode);
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Do you have nasal allergy?',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF2C698D)),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: TextFormField(
                              style: TextStyle(fontSize: 20),
                              controller: nasalController,
                              validator: (text) {
                                if (text == '') {
                                  return 'Please Answer';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: (BorderRadius.circular(20))),
                                hintText: (" Nasal allergy"),
                                hintStyle: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black45,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              onFieldSubmitted: (String value) {
                                FocusScope.of(context)
                                    .requestFocus(textSecondFocusNode);
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                    'Do you have allergy from any active substance?',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF2C698D))),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: TextFormField(
                              controller: substanceController,
                              validator: (text) {
                                if (text == '') {
                                  return 'Please Answer';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: (BorderRadius.circular(20))),
                                hintText: ("Active substance allergy"),
                                hintStyle: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black45,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              onFieldSubmitted: (String value) {
                                FocusScope.of(context)
                                    .requestFocus(textSecondFocusNode);
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text('Do you have skin allergy?',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF2C698D))),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: TextFormField(
                              controller: skinController,
                              validator: (text) {
                                if (text == '') {
                                  return 'Please Answer';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: (BorderRadius.circular(20))),
                                hintText: ("Skin allergy"),
                                hintStyle: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black45,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              onFieldSubmitted: (String value) {
                                FocusScope.of(context)
                                    .requestFocus(textSecondFocusNode);
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text('What type of food you are allergic to?',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF2C698D))),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: TextFormField(
                              controller: foodController,
                              validator: (text) {
                                if (text == '') {
                                  return 'Please Answer';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: (BorderRadius.circular(20))),
                                hintText: ("Type of food you are allergic to"),
                                hintStyle: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black45,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              onFieldSubmitted: (String value) {
                                FocusScope.of(context)
                                    .requestFocus(textSecondFocusNode);
                              },
                            ),
                          ),
                        ])),
                  ),
                )));
      },
    );
  }

  @override
  AllergyViewModel initViewModel() {
    return AllergyViewModel();
  }
}
