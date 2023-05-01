import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:grad_project/basenavigator.dart';
import 'package:grad_project/Home_layout/navv.dart';
import 'package:grad_project/models/my_patient.dart';
import 'package:grad_project/create_account/patient_nav.dart';
import 'package:grad_project/create_account/patientsignup_viewmodel.dart';
import 'package:provider/provider.dart';
import '../login/patient_login.dart';
import '../myprovider.dart';

class PatientSignup extends StatefulWidget {
  static const String routeName = 'patientsignup';

  @override
  State<PatientSignup> createState() => _PatientSignupState();
}

class _PatientSignupState
    extends BaseView<PatientSignup, patientsignupViewModel>
    implements PatientAccountNavigator {
  var email, username, password;

  bool passwordVisible = false;

  bool confirmPasswordVisible = false;

  GlobalKey<FormState> formstate = new GlobalKey<FormState>();

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var confirmPasswordController = TextEditingController();

  var fullnamecontroller = TextEditingController();

  var usernamecontroller = TextEditingController();

  var Mobilenumbercontroller = TextEditingController();

  var imagecontroller = TextEditingController();

  var qrcodecontroller = TextEditingController();

  patientsignupViewModel viewmodel = patientsignupViewModel();

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
                    key: formstate,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(child: Image.asset('assets/images/Group 2.png')),
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
                          }),
                          onFieldSubmitted: (String value) {
                            print(value);
                          },
                          controller: fullnamecontroller,
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
                          height: 5,
                        ),
                        //username
                        Text(
                          'User Name',
                          style: TextStyle(
                            color: Color(0xFF2C698D),
                            fontSize: 13,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          onFieldSubmitted: (String value) {
                            print(value);
                          },
                          onSaved: (val) {
                            username = val;
                          },
                          validator: (val) {
                            if (val!.length > 50) {
                              return "username can't be greater than 50 letter";
                            }
                            if (val.length < 4) {
                              return "username can't be smaller than 4 letter";
                            }
                            return null;
                          },
                          controller: usernamecontroller,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            hintText: 'User Name',
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
                          height: 5,
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
                          height: 5,
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
                          height: 5,
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
                          height: 5,
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
                          height: 5,
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
                          height: 5,
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
                          obscureText: true,
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
                            hintText: ' Confirm Password',
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
                                  //shadowColor: Colors.transparent,
                                ),
                                onPressed: () {
                                  PatientSignupValidation();
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
                                              PatientLogin())); // navigator byn2l l page tanya
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

  void PatientSignupValidation() async {
    if (formstate.currentState!.validate()) {
      viewModel.signupViewModel(
          emailController.text,
          passwordController.text,
          fullnamecontroller.text,
          usernamecontroller.text,
          Mobilenumbercontroller.text,
          imagecontroller.text,
          qrcodecontroller.text);
    }
  }

  @override
  void goToHome(MyPatient patient) {
    // go to home screen
    Provider.of<MyProvider>(context, listen: false);

    Navigator.pushReplacementNamed(context, navv.routeName);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.navigator = this;
  }

  @override
  patientsignupViewModel initViewModel() {
    // TODO: implement initViewModel
    return patientsignupViewModel();
  }
}
