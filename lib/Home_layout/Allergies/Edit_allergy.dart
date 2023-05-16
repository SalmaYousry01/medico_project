import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'allergy_viewmodel.dart';

class EditAllergyBottomsheet extends StatefulWidget {
  final allergyid;

  const EditAllergyBottomsheet({this.allergyid});

  @override
  State<EditAllergyBottomsheet> createState() => _EditAllergyBottomsheetState();
}

class _EditAllergyBottomsheetState extends State<EditAllergyBottomsheet> {
  var chestController = TextEditingController();

  var nasalController = TextEditingController();
  var skinController = TextEditingController();

  var foodController = TextEditingController();
  var substanceController = TextEditingController();

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  AllergyViewModel viewModel = AllergyViewModel();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Text('Add New Medicine', style: TextStyle(fontSize: 20)),
            SizedBox(
              height: 10,
            ),
            Form(
              key: formkey,
              child: Column(
                children: [
                  TextFormField(
                      controller: nasalController,
                      validator: (text) {
                        if (text == '') {
                          return 'please enter name';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          label: Text('Task Title'),
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Color(0xFF2C698D))))),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                      controller: chestController,
                      validator: (text) {
                        if (text == '') {
                          return 'please enter description';
                        }
                        return null;
                      },
                      maxLines: 5,
                      decoration: InputDecoration(
                          label: Text('Note Content'),
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Color(0xFF2C698D))))),
                  TextFormField(
                      controller: foodController,
                      validator: (text) {
                        if (text == '') {
                          return 'please enter name';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          label: Text('Task Title'),
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Color(0xFF2C698D))))),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                      controller: skinController,
                      validator: (text) {
                        if (text == '') {
                          return 'please enter name';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          label: Text('Task Title'),
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Color(0xFF2C698D))))),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                      controller: substanceController,
                      validator: (text) {
                        if (text == '') {
                          return 'please enter name';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          label: Text('Task Title'),
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Color(0xFF2C698D))))),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),

            //Form(
            //key: formkey,
            //child: Column(
            //children: [

            // ],
            // )
            //),
            SizedBox(
              height: 15,
            ),

            Container(
              width: double.infinity,
              height: 46.13,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF2C698D),
                  ),
                  onPressed: () {
                    ValidateNote();

                    Navigator.pop(context);
                  },
                  child: Text('Save Changes')),
            ),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }

  hideLoading(BuildContext context) {
    Navigator.pop(context);
  }

  Future<void> ValidateNote() async {
    if (formkey.currentState!.validate()) {
      await viewModel.AddOrUpdateAllergyToDB(
        chestController.text,
        skinController.text,
        foodController.text,
        substanceController.text,
        nasalController.text,
      );
    }
  }

  @override
  AllergyViewModel initViewModel() {
    return AllergyViewModel();
  }
}
