import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grad_project/Home_layout/medicine/medicine_items.dart';
import 'package:grad_project/Home_layout/medicine/medicine_viewmodel.dart';

import '../../DatabaseUtils/medicine_database.dart';
import '../../models/my_medicine.dart';

class medicine extends StatefulWidget {
  const medicine({Key? key}) : super(key: key);

  @override
  State<medicine> createState() => _medicineState();
  static const String routeName = 'medicine';
}

class _medicineState extends State<medicine> {
  var _formKey = GlobalKey<FormState>();




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/welcome page.png"), fit: BoxFit.cover)),
        child:FutureBuilder<QuerySnapshot<Mymedicine>>(
            future:getmedicinetofirestore(),
            builder:(context, snapshot) {
              if (snapshot.connectionState==ConnectionState.waiting){
                return Center(child: CircularProgressIndicator());
              }
              if(snapshot.hasError){
                return Center(child: Text('something went wrong'));
              }
              var medicine=snapshot.data?.docs.map((docs) => docs.data()).toList()??[];
              return medicine.length > 0
                  ? Expanded(
                child: ListView.builder(
                    itemCount: medicine.length,
                    itemBuilder: (context,Index){
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
                        style: TextStyle(fontSize: 25, color: Colors.white),
                      ),
                      Container( height: 37,

                          child: Image.asset('assets/icons/medicinehome.png',color:  Colors.white,))
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
                              onPressed: () {
                              },
                              icon: Image.asset('icons/medicine.time2.png',color:Color(0xFF2C698D,), )
                          ),
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
    TextEditingController nameController = TextEditingController();
    TextEditingController dosageController = TextEditingController();

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
                        child: Column(
                            children: <Widget>[
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
                                          Mymedicine medicine = Mymedicine(
                                            dosage: dosageController.text,
                                            name: nameController.text,
                                          );
                                          // showLoading(context, 'Saving note');
                                          AddmedicineToFirestore(medicine);
                                          // hideLoading(context);
                                        });

                                        Navigator.pop(context);
                                      }
                                      print(dosageController.text);
                                      print(nameController.text);

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
                                padding: const EdgeInsets.only(top: 20),
                                child: TextFormField(
                                  controller: nameController,
                                  validator: (text) {
                                    if (text == '') {
                                      return 'Please Enter Medicine';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    suffixIcon: Container(height: 1,child: Image.asset('assets/icons/pills.png',)),
                                    border: OutlineInputBorder(
                                        borderRadius: (BorderRadius.circular(20))),
                                    hintText: "Medicine Name",
                                    labelText: "Medicine Name",
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
                              SizedBox(height: 17,),
                              Padding(
                                padding: const EdgeInsets.only(top: 15),
                                child: Container(
                                  color: Colors.transparent,
                                  margin: EdgeInsets.all(1),
                                  child: TextFormField(
                                    controller: dosageController,
                                    validator: (text) {
                                      if (text == '') {
                                        return 'Please Enter Your Dosage';
                                      }
                                      return null;
                                    },
                                    keyboardType: TextInputType.multiline,
                                    maxLines: null,
                                    decoration: InputDecoration(
                                      suffixIcon: Container(height: 1,child: Image.asset('assets/icons/dosage2.png',)),
                                      border: OutlineInputBorder(
                                          borderRadius: (BorderRadius.circular(20))),
                                      hintText: 'Dosage',
                                      labelText: 'Dosage',
                                      hintStyle: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black45,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ),




                            ]
                        )


                    ),
                  ),
                )
            )

        );

      },
    );
  }

  @override
  MedicineViewModel initViewModel() {
    return MedicineViewModel();
  }


}
