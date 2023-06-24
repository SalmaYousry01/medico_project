import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'reminder_viewmodel.dart';

class EditReminderBottomsheet extends StatefulWidget {
  final Reminderid;

  const EditReminderBottomsheet({this.Reminderid});

  @override
  State<EditReminderBottomsheet> createState() =>
      _EditReminderBottomsheetState();
}

class _EditReminderBottomsheetState extends State<EditReminderBottomsheet> {
  var titleController = TextEditingController();
  var descriptionsController = TextEditingController();
  var dateController = TextEditingController();
  var timeController = TextEditingController();

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  ReminderViewModel viewModel = ReminderViewModel();

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
                      controller: titleController,
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
                      controller: descriptionsController,
                      validator: (text) {
                        if (text == '') {
                          return 'please enter description';
                        }
                        return null;
                      },
                      maxLines: 5,
                      decoration: InputDecoration(
                          label: Text('Reminder Content'),
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Color(0xFF2C698D))))),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                      controller: dateController,
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
                      controller: timeController,
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
                ],
              ),
            ),
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
                    ValidateReminder();

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

  Future<void> ValidateReminder() async {
    if (formkey.currentState!.validate()) {
      await viewModel.AddOrUpdateReminderToDB(
        titleController.text,
        descriptionsController.text,
        timeController.text,
        dateController.text,
      );
    }
  }

  @override
  ReminderViewModel initViewModel() {
    return ReminderViewModel();
  }
}
