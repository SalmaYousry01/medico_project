import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grad_project/view_only_patient/view_only_patient_view.dart';
import '../DatabaseUtils/medicine_database.dart';
import '../Home_layout/medicine/medicine_items.dart';
import '../Home_layout/medicine/medicine_viewmodel.dart';
import '../models/my_medicine.dart';

class MedicineView extends StatefulWidget {
  const MedicineView({Key? key}) : super(key: key);

  @override
  State<MedicineView> createState() => MedicineViewState();
  static const String routeName = 'medicineview';
}

class MedicineViewState extends State<MedicineView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ViewOnlyPatientView(),
                ),
              );
            },
            icon: Icon(Icons.arrow_back)),
        title: Text('Medicine'),
        centerTitle: true,
        backgroundColor: Color(0xFF2C698D),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/welcome page.png"),
                fit: BoxFit.cover)),
        child: FutureBuilder<QuerySnapshot<Mymedicine>>(
            future: getmedicinetofirestore(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text('something went wrong'));
              }
              var medicine =
                  snapshot.data?.docs.map((docs) => docs.data()).toList() ?? [];
              return medicine.length > 0
                  ? Expanded(
                      child: ListView.builder(
                          itemCount: medicine.length,
                          itemBuilder: (context, Index) {
                            return MedicineItem(medicine[Index]);
                          }),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(left: 95, top: 70),
                      child: Center(
                        child: Row(
                          children: [
                            Text(
                              "Add New Medicine..",
                              style:
                                  TextStyle(fontSize: 25, color: Colors.white),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                                height: 37,
                                child: Image.asset(
                                  'assets/images/medicinehome.png',
                                ))
                          ],
                        ),
                      ),
                    );
            }),
      ),
    );
  }

  Widget buildMedicine() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10,
        left: 10,
        right: 10,
      ),
      child: new ListView.builder(
        itemCount: name.length,
        itemBuilder: (context, int index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 5.5),
            child: new Dismissible(
              key: UniqueKey(),
              direction: DismissDirection.horizontal,
              onDismissed: (direction) {
                setState(() {
                  deletedname = name[index];
                  deleteddosage = dosage[index];
                  name.removeAt(index);
                  dosage.removeAt(index);
                  //  Scaffold.of(context).showSnackBar(
                });
              },
              //delete
              background: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Container(
                  color: Colors.red,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                          Text(
                            "Delete",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              child: medicineList(index),
            ),
          );
        },
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
        height: 70,
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
                            name[index],
                            style: TextStyle(
                              fontSize: 20.00,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          subtitle: Text(
                            dosage[index],
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          trailing: IconButton(
                              onPressed: () {},
                              icon: Image.asset(
                                'images/medicinehome.png',
                                color: Color(
                                  0xFF2C698D,
                                ),
                              )),
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

  @override
  MedicineViewModel initViewModel() {
    return MedicineViewModel();
  }
}
