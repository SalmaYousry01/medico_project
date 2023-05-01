import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:grad_project/basenavigator.dart';
import 'package:grad_project/create_account/doctor_nav.dart';
import 'package:grad_project/models/my_doctor.dart';
import 'package:provider/provider.dart';
import '../Profile/clinicProfile.dart';
import '../login/doctor_login.dart';
import '../models/field_category.dart';
import '../myprovider.dart';
import 'doctor_signup_viewmodel.dart';

class DoctorSignup extends StatefulWidget {
  static const String routeName = 'DoctorSignup';

  @override
  State<DoctorSignup> createState() => _DoctorSignupState();
}

class _DoctorSignupState extends BaseView<DoctorSignup, DoctorSignupViewModel>
    implements DoctorAccountNavigator {
  var email, idNumber, password;
  bool passwordVisible = false;
  bool confirmPasswordVisible = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var fullnamecontroller = TextEditingController();
  var Fieldcontroller = TextEditingController();
  var IDcontroller = TextEditingController();
  var imagecontroller = TextEditingController();

  var Mobilenumbercontroller = TextEditingController();
  DoctorSignupViewModel viewModel = DoctorSignupViewModel();

  var fieldCategories = FieldCategory.getCategories();
  late FieldCategory selectedField;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Stack(
        children: [
          Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(5),
              child: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0.0,
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(child: Image.asset('assets/images/Group 3.png')),
                        SizedBox(
                          height: 0,
                        ),
                        Center(
                          child: Text(
                            "Create an account.",
                            style: TextStyle(
                              color: Color(0xFF2C698D),
                              fontSize: 13,
                            ),
                          ),
                        ),
                        //Full name
                        Text(
                          textAlign: TextAlign.start,
                          'Full Name',
                          style: TextStyle(
                            color: Color(0xFF2C698D),
                            fontSize: 13,
                          ),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        TextFormField(
                          validator: ((Text) {
                            if (Text!.trim() == '') {
                              return "please enter your full name";
                            }
                            return null;
                          }),
                          controller: fullnamecontroller,
                          onFieldSubmitted: (String value) {
                            print(value);
                          },
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            hintText: 'Full Name',
                            prefixIcon:
                                Icon(Icons.person, color: Color(0xFF2C698D)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(7.69),
                                borderSide:
                                    BorderSide(color: Color(0xFF2C698D))),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(7.69),
                                borderSide:
                                    BorderSide(color: Color(0xFF2C698D))),
                          ),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        //username
                        Text(
                          'ID number',
                          style: TextStyle(
                            color: Color(0xFF2C698D),
                            fontSize: 13,
                          ),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        TextFormField(
                          onFieldSubmitted: (String value) {
                            print(value);
                          },
                          onSaved: (val) {
                            idNumber = val;
                          },
                          validator: (val) {
                            if (val!.length > 14) {
                              return "ID number can't be greater than 14 numbers";
                            }
                            if (val.length < 14) {
                              return "ID number can't be smaller than 14 numbers";
                            }
                            return null;
                          },
                          controller: IDcontroller,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            hintText: 'ID number',
                            prefixIcon:
                                Icon(Icons.person, color: Color(0xFF2C698D)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(7.69),
                                borderSide:
                                    BorderSide(color: Color(0xFF2C698D))),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(7.69),
                                borderSide:
                                    BorderSide(color: Color(0xFF2C698D))),
                          ),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        //phone number
                        Text(
                          'Mobile Number',
                          style: TextStyle(
                            color: Color(0xFF2C698D),
                            fontSize: 13,
                          ),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        TextFormField(
                          onFieldSubmitted: (String value) {
                            print(value);
                          },
                          controller: Mobilenumbercontroller,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            hintText: 'Mobile Number',
                            prefixIcon:
                                Icon(Icons.phone, color: Color(0xFF2C698D)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(7.69),
                                borderSide:
                                    BorderSide(color: Color(0xFF2C698D))),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(7.69),
                                borderSide:
                                    BorderSide(color: Color(0xFF2C698D))),
                          ),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        //phone number
                        Text(
                          'Field',
                          style: TextStyle(
                            color: Color(0xFF2C698D),
                            fontSize: 13,
                          ),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Container(
                          child: DropdownButton<FieldCategory>(
                            value: selectedField,
                            items: fieldCategories
                                .map((cat) => DropdownMenuItem<FieldCategory>(
                                      value: cat,
                                      child: Row(
                                        children: [Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(cat.name),
                                        )],
                                      ),
                                    ))
                                .toList(),
                            onChanged: (category) {
                              if (category == null) {
                                return;
                              } else {
                                selectedField = category;
                              }
                              setState(() {});
                            },
                          ),
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: BorderSide( style: BorderStyle.solid, color: Color(0xFF2C698D)),
                              borderRadius: BorderRadius.all(Radius.circular(7.69)),
                        ),),),
                        SizedBox(
                          height: 3,
                        ),
                        //email
                        Text(
                          'Email Address',
                          style: TextStyle(
                            color: Color(0xFF2C698D),
                            fontSize: 13,
                          ),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        TextFormField(
                          onChanged: (String value) {
                            print(value);
                          },
                          onFieldSubmitted: (String value) {
                            print(value);
                          },
                          onSaved: (val) {
                            email = val;
                          },
                          validator: (text) {
                            if (text!.trim() == "") {
                              return "Please Enter Email";
                            }
                            final bool emailValid = RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(text);
                            if (!emailValid) {
                              return "please Enter Valid email";
                            }
                            return null;
                          },
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: 'Email Address',
                            prefixIcon: Icon(
                              Icons.email,
                              color: Color(0xFF2C698D),
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(7.69),
                                borderSide:
                                    BorderSide(color: Color(0xFF2C698D))),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(7.69),
                                borderSide:
                                    BorderSide(color: Color(0xFF2C698D))),
                          ),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        //password
                        Text(
                          'Password',
                          style: TextStyle(
                            color: Color(0xFF2C698D),
                            fontSize: 13,
                          ),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        TextFormField(
                          obscureText: !passwordVisible,
                          onChanged: (String value) {
                            print(value);
                          },
                          onFieldSubmitted: (String value) {
                            print(value);
                          },
                          onSaved: (val) {
                            password = val;
                          },
                          validator: (text) {
                            if (text!.trim() == "") {
                              return "Please Enter Password";
                            }
                            if (text.length < 4) {
                              return "password can't be smaller than 4 letter";
                            }
                            return null;
                          },
                          controller: passwordController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            prefixIcon:
                                Icon(Icons.lock, color: Color(0xFF2C698D)),
                            suffixIcon: IconButton(
                              icon: Icon(
                                passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Theme.of(context).primaryColorDark,
                              ),
                              onPressed: () {
                                setState(() {
                                  passwordVisible = !passwordVisible;
                                });
                              },
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(7.69),
                                borderSide:
                                    BorderSide(color: Color(0xFF2C698D))),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(7.69),
                                borderSide:
                                    BorderSide(color: Color(0xFF2C698D))),
                          ),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        //password check
                        Text(
                          'Confirm Password',
                          style: TextStyle(
                            color: Color(0xFF2C698D),
                            fontSize: 13,
                          ),
                        ),
                        TextFormField(
                          obscureText: !confirmPasswordVisible,
                          onChanged: (String value) {
                            print(value);
                          },
                          onFieldSubmitted: (String value) {
                            print(value);
                          },
                          controller: confirmPasswordController,
                          validator: (val) {
                            if (val!.isEmpty) return 'Empty';
                            if (val != passwordController.text)
                              return 'Not Match';
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: 'Confirm Password',
                            prefixIcon:
                                Icon(Icons.lock, color: Color(0xFF2C698D)),
                            suffixIcon: IconButton(
                              icon: Icon(
                                confirmPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Theme.of(context).primaryColorDark,
                              ),
                              onPressed: () {
                                setState(() {
                                  confirmPasswordVisible =
                                      !confirmPasswordVisible;
                                });
                              },
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(7.69),
                                borderSide:
                                    BorderSide(color: Color(0xFF2C698D))),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(7.69),
                                borderSide:
                                    BorderSide(color: Color(0xFF2C698D))),
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
                                  DoctorSignupValidation();
                                },
                                child: Text("SIGN UP"))),
                        SizedBox(
                          height: 0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Already have an account?'),
                            TextButton(
                              onPressed: (() {
                                setState(() {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DoctortLogin())); // navigator byn2l l page tanya
                                });
                              }),
                              child: Text('Log in'),
                            ),
                          ],
                        )
                      ],
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void DoctorSignupValidation() async {
    if (formKey.currentState!.validate()) {
      viewModel.doctorSignupWithFirebaseAuth(
          emailController.text,
          passwordController.text,
          fullnamecontroller.text,
          IDcontroller.text,
          Mobilenumbercontroller.text,
          selectedField.name,
          imagecontroller.text);
    }
  }

  @override
  void goToProfilePage(DoctorDataBase doctor) {
    // go to home screen
    Provider.of<MyProvider>(context, listen: false);
    Navigator.pushReplacementNamed(context, ClinicProfile.routeName, arguments: true);
  }

  @override
  void initState() {
    super.initState();
    viewModel.navigator = this;
    selectedField = fieldCategories[0];
  }

  @override
  DoctorSignupViewModel initViewModel() {
    return DoctorSignupViewModel();
  }
}
