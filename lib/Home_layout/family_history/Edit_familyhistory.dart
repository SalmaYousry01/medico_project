import 'package:flutter/material.dart';

import 'familyhistory_viewmodel.dart';

class EditFamilyhistoryBottomsheet extends StatefulWidget {
  final familyhistoryid;

  const EditFamilyhistoryBottomsheet({this.familyhistoryid});

  @override
  State<EditFamilyhistoryBottomsheet> createState() =>
      _EditFamilyhistoryBottomsheetState();
}

class _EditFamilyhistoryBottomsheetState
    extends State<EditFamilyhistoryBottomsheet> {
  var detailsController = TextEditingController();
  var degreeController = TextEditingController();

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  FamilyhistoryViewModel viewModel = FamilyhistoryViewModel();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            Form(
              key: formkey,
              child: Column(
                children: [
                  TextFormField(
                      controller: detailsController,
                      validator: (text) {
                        if (text == '') {
                          return 'please enter your medical issues';
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
                      controller: degreeController,
                      validator: (text) {
                        if (text == '') {
                          return 'please enter degree of relatedness';
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
      await viewModel.AddOrUpdateFamilyhistoryToDB(
        detailsController.text,
        degreeController.text,
      );
    }
  }

  @override
  FamilyhistoryViewModel initViewModel() {
    return FamilyhistoryViewModel();
  }
}
