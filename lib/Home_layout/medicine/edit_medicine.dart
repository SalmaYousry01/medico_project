import 'package:flutter/material.dart';

import 'medicine_viewmodel.dart';

class EditMedicineBottomsheet extends StatefulWidget {
  final medicineid;

  const EditMedicineBottomsheet({this.medicineid});

  @override
  State<EditMedicineBottomsheet> createState() => _EditMedicineBottomsheetState();
}

class _EditMedicineBottomsheetState extends State<EditMedicineBottomsheet> {
  var dosageController = TextEditingController();

  var nameController = TextEditingController();

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  MedicineViewModel viewModel = MedicineViewModel();

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
                      controller: nameController,
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
                      controller: dosageController,
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
      await viewModel.AddOrUpdateMedicineToDB(
        nameController.text,
        dosageController.text,
      );
    }
  }

  @override
  MedicineViewModel initViewModel() {
    return MedicineViewModel();
  }
}
