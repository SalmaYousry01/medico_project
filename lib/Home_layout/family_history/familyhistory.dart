import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../DatabaseUtils/familyhistory_database.dart';
import '../home.dart';
import 'familyhistory.items.dart';
import '../../models/my_family.dart';
import 'familyhistory_viewmodel.dart';

class FamilyHistory extends StatefulWidget {
  @override
  State<FamilyHistory> createState() => _FamilyHistoryState();
  static const String routeName = 'familyhistory1';
}

class _FamilyHistoryState extends State<FamilyHistory> {
  TextEditingController degreeController = new TextEditingController();
  TextEditingController detailsController = new TextEditingController();

  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 35),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 20),
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => home(),
                              ),
                            );
                          },
                          icon: Icon(
                            Icons.arrow_back,
                            size: 30,
                          )),
                      Text(
                        " Family history",
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
              ],
            ),
            const Divider(
              color: Color(0xFF216B98),
              height: 37,
            ),
            Container(
              child: FutureBuilder<QuerySnapshot<MyFamilyhistory>>(
                  future: getFamilyhistorytofirestore(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text('Something went wrong'));
                    }
                    var familyhistory = snapshot.data?.docs
                            .map((docs) => docs.data())
                            .toList() ??
                        [];
                    return Expanded(
                      child: ListView.builder(
                          itemCount: familyhistory.length,
                          itemBuilder: (context, Index) {
                            return FamilyhistoryItem(familyhistory[Index]);
                          }),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }

  void _settingModalBottomSheet(context) {
    TextEditingController detailsController = TextEditingController();
    TextEditingController degreeController = TextEditingController();

    showModalBottomSheet(
      context: context,
      //   isScrollControlled: true,
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
                                      MyFamilyhistory familyhistory =
                                          MyFamilyhistory(
                                        details: detailsController.text,
                                        degree: degreeController.text,
                                      );
                                      // showLoading(context, 'Saving note');
                                      AddFamilyhistoryToFirestore(
                                          familyhistory);
                                      // hideLoading(context);
                                    });

                                    Navigator.pop(context);
                                  }
                                  print(detailsController.text);
                                  print(degreeController.text);
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
                                Text(
                                  'Specify the medical issues your family members have?',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                      color: Color(0xFF2C698D)),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: TextFormField(
                              style: TextStyle(fontSize: 20),
                              controller: detailsController,
                              validator: (text) {
                                if (text == '') {
                                  return 'Please Answer';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: (BorderRadius.circular(20))),
                                hintText: ("Type..."),
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
                                Text('Degree of retatedeness',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF2C698D))),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: TextFormField(
                              controller: degreeController,
                              validator: (text) {
                                if (text == '') {
                                  return 'Please Answer';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: (BorderRadius.circular(20))),
                                hintText: ("Type...."),
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
  FamilyhistoryViewModel initViewModel() {
    return FamilyhistoryViewModel();
  }
}
