import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:grad_project/DatabaseUtils/reminder_database.dart';
import 'package:grad_project/Home_layout/Reminder/reminder_items.dart';
import 'package:grad_project/Home_layout/Reminder/reminder_viewmodel.dart';
import 'package:grad_project/models/my_reminder.dart';
import 'package:intl/intl.dart';
import 'notification_service.dart';

class reminder1 extends StatefulWidget {
  // NotesPage({Key key}) : super(key: key);
  static const String routeName = 'reminder1';

  @override
  _reminder1State createState() => _reminder1State();
}

class _reminder1State extends State<reminder1> {
  var _formKey = GlobalKey<FormState>();

  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  DateTime scheduleTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(
        //     onPressed: () {
        //       Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //           builder: (context) => home(),
        //         ),
        //       );
        //     },
        //     icon: Icon(Icons.arrow_back)),
        title: Text('Reminder'),
        centerTitle: true,
        backgroundColor: Color(0xFF2C698D),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/background.png"),
                fit: BoxFit.cover)),
        child: FutureBuilder<QuerySnapshot<MyReminder>>(
            future: getRemindertofirestore(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text('something went wrong'));
              }
              var Reminder =
                  snapshot.data?.docs.map((docs) => docs.data()).toList() ?? [];
              return Reminder.length > 0
                  ? Expanded(
                      child: ListView.builder(
                          itemCount: Reminder.length,
                          itemBuilder: (context, Index) {
                            return ReminderItem(Reminder[Index]);
                          }),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(left: 95, top: 70),
                      child: Center(
                        child: Row(
                          children: [
                            Text(
                              "Add New Reminder...",
                              style:
                                  TextStyle(fontSize: 25, color: Colors.white),
                            ),
                            Container(
                                height: 37,
                                child: Image.asset(
                                  'assets/images/reminders.png',
                                ))
                          ],
                        ),
                      ),
                    );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        mini: false,
        backgroundColor: Color(0xFF2C698D),
        child: const Icon(Icons.add),
        onPressed: () {
          _settingModalBottomSheet(context);
        },
      ),
    );
  }

  void _settingModalBottomSheet(context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionsController = TextEditingController();
    TextEditingController dateController = TextEditingController();
    TextEditingController timeController = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: false,
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
                                padding: const EdgeInsets.only(right: 200),
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
                                      MyReminder reminder = MyReminder(
                                          descriptions:
                                              descriptionsController.text,
                                          title: titleController.text,
                                          date: dateController.text,
                                          time: timeController.text);
                                      // showLoading(context, 'Saving note');
                                      AddReminderToFirestore(reminder);
                                      // hideLoading(context);
                                    });

                                    Navigator.pop(context);
                                  }
                                  print(descriptionsController.text);
                                  print(titleController.text);
                                  print(dateController.text);
                                  print(timeController.text);
                                  debugPrint(
                                      'Notification Scheduled for $scheduleTime');
                                  NotificationService().scheduleNotification(
                                      title: titleController.text,
                                      descriptions: descriptionsController.text,
                                      scheduledNotificationDateTime:
                                          scheduleTime);
                                },
                                child: Container(
                                  child: Row(
                                    children: [
                                      Text(
                                        "Done",
                                        style: TextStyle(
                                          fontSize: 20.00,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: TextFormField(
                              controller: titleController,
                              validator: (text) {
                                if (text == '') {
                                  return 'Please Enter Reminder';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                suffixIcon: Icon(Icons.alarm),
                                border: OutlineInputBorder(
                                    borderRadius: (BorderRadius.circular(20))),
                                hintText: "Reminder Name",
                                labelText: "Reminder Name",
                                hintStyle: TextStyle(
                                  fontSize: 18,
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
                            padding: const EdgeInsets.only(top: 15),
                            child: Container(
                              color: Colors.transparent,
                              margin: EdgeInsets.all(1),
                              child: TextFormField(
                                controller: descriptionsController,
                                validator: (text) {
                                  if (text == '') {
                                    return 'Please Enter Reminder Descripition';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                decoration: InputDecoration(
                                  suffixIcon: Icon(Icons.notes_outlined),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          (BorderRadius.circular(20))),
                                  hintText: 'Description',
                                  labelText: 'Description',
                                  hintStyle: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black45,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: double.infinity,
                            height: 60,
                            child: TextButton(
                              onPressed: () {
                                DatePicker.showDateTimePicker(
                                  context,
                                  showTitleActions: true,
                                  onChanged: (date) => scheduleTime = date,
                                  onConfirm: (date) {},
                                );
                                if (scheduleTime != null) {
                                  setState(() {
                                    dateController.text =
                                        DateFormat.yMd().format(scheduleTime);
                                    timeController.text =
                                        DateFormat.Hm().format(scheduleTime);
                                  });
                                }
                              },
                              child: const Text(
                                'Pick Date & Time',
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                              style: ButtonStyle(
                                  foregroundColor: MaterialStateProperty.all(
                                    Colors.white70,
                                  ),
                                  backgroundColor: MaterialStateProperty.all(
                                    Color(0xFF2C698D),
                                  ),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ))),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ])),
                  ),
                )));
      },
    );
  }

  @override
  ReminderViewModel initViewModel() {
    return ReminderViewModel();
  }
}
