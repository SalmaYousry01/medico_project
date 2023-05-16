import 'package:flutter/material.dart';

class FamilyHistory extends StatefulWidget {
  static const String routeName = "FamilyHistory";

  @override
  State<FamilyHistory> createState() => _FamilyHistoryState();
}

class _FamilyHistoryState extends State<FamilyHistory> {
  TextEditingController _detailsEditingController = TextEditingController();
  TextEditingController _relatedEditingController = TextEditingController();
  String? details;
  String? relation;
  List<String> details_list = [];
  List<String> relation_list = [];
  final subcollection = [];

  bool _showList = false;

  void _addData() {
    subcollection.add({
      'medicine': _detailsEditingController.text,
      'relation': _relatedEditingController.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 85,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          title: Text(
            'Family History',
            style: TextStyle(color: Colors.white, fontSize: 30),
          ),
          backgroundColor: Color(0xFF2C698D),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                setState(() {
                  Navigator.pop(context);
                });
              },
              icon: Icon(
                Icons.arrow_back_outlined,
                size: 25,
              ))),
      body: Padding(
        padding: EdgeInsets.only(top: 30, left: 12),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Specify the medical issues your family members have.',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.only(right: 10, left: 10),
                child: TextFormField(
                  controller: _detailsEditingController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    suffixIcon: Icon(Icons.medical_information),
                    hintText: 'Type..',
                    helperText: 'Ex: Blood Pressure, Allergy...',
                    hintStyle: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Degree of relatedness',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.only(right: 10, left: 10),
                child: TextFormField(
                  style: TextStyle(fontSize: 20),
                  controller: _relatedEditingController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    suffixIcon: Icon(Icons.face),
                    hintText: 'Type..',
                    helperText: 'Ex: Father, Mother...',
                    hintStyle: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              SizedBox(height: 35),
              Center(
                child: Container(
                  width: 180,
                  height: 65,
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    color: Color(0xFF2C698D),
                    child: Text(
                      'Submit',
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                    onPressed: () {
                      setState(() {
                        _addData();
                        if (_detailsEditingController.text.isNotEmpty) {
                          details_list.add(_detailsEditingController.text);
                          _detailsEditingController.clear();
                        }
                        if (_relatedEditingController.text.isNotEmpty) {
                          relation_list.add(_relatedEditingController.text);
                          _relatedEditingController.clear();
                        } else {
                          return null;
                        }
                        _showList = true;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: 30),
              Padding(
                padding: EdgeInsets.only(right: 10),
                child: Visibility(
                    visible: _showList,
                    child: Container(
                      width: 400,
                      height: 160,
                      decoration: BoxDecoration(
                        color: Color(0xFF2C698D),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 15, top: 15),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    'Information:',
                                    style: TextStyle(
                                        fontSize: 23,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    '$details_list',
                                    style: TextStyle(
                                        fontSize: 23,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400),
                                  )
                                ],
                              ),
                              SizedBox(height: 15),
                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 5),
                                  Padding(
                                    padding: EdgeInsets.only(top: 8),
                                    child: Text(
                                      'Degree of \nrelatedness:',
                                      style: TextStyle(
                                          fontSize: 23,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Padding(
                                    padding: EdgeInsets.only(top: 32),
                                    child: Text(
                                      '$relation_list',
                                      style: TextStyle(
                                          fontSize: 23,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
