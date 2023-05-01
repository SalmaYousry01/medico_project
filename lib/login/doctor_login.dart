import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:grad_project/Home_layout/navv.dart';
import 'package:grad_project/Profile/clinicProfile.dart';
import 'package:grad_project/Profile/clinicProfile_navigator.dart';
import 'package:grad_project/basenavigator.dart';
import 'package:grad_project/create_account/doctor_signup.dart';
import 'package:grad_project/login/doctorlogin_navigator.dart';
import 'package:grad_project/models/my_doctor.dart';
import 'package:provider/provider.dart';
import '../myprovider.dart';
import 'doctorlogin_viewmodel.dart';

class DoctortLogin extends StatefulWidget {
  static const String routeName = 'DoctortLogin';

  const DoctortLogin({super.key});

  @override
  State<DoctortLogin> createState() => _DoctortLoginState();
}

class _DoctortLoginState extends BaseView<DoctortLogin,doctorloginViewModel> implements DoctorLoginNavigator{
  var email, password;

  bool passwordVisible = false;
  var passwordController = TextEditingController();
  var emailController = TextEditingController();

  GlobalKey<FormState> formstate = new GlobalKey<FormState>();

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
                        Center(child: Image.asset('assets/images/Group 3.png')),
                        SizedBox(
                          height: 5,
                        ),
                        Center(
                          child: Text(
                            "Doctor",
                            style: TextStyle(
                              color: Color(0xFF2C698D),
                              fontSize: 18,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        //email
                        Text(
                          'Email/Phone number',
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
                          controller: emailController,
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
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: 'Email/Phone number',
                            prefixIcon: Icon(
                              Icons.email,
                              color: Color(0xFF2C698D),
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(7.69),
                                borderSide: BorderSide(color: Color(0xFF2C698D))),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(7.69),
                                borderSide: BorderSide(color: Color(0xFF2C698D))),
                          ),
                        ),
                        SizedBox(
                          height: 20,
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
                                borderSide: BorderSide(color: Color(0xFF2C698D))),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(7.69),
                                borderSide: BorderSide(color: Color(0xFF2C698D))),
                          ),
                        ),
                        SizedBox(
                          height: 20,
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
                                  if(formstate.currentState!.validate()){
                                    ValidateForm();
                                  }
                                },
                                child: Text("LOGIN"))),

                        SizedBox(
                          height: 0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(' Or Creat an account?'),
                            TextButton(
                              onPressed: (() {
                                setState(() {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DoctorSignup())); // navigator byn2l l page tanya
                                });
                              }),
                              child: Text('Sing up'),
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

  void ValidateForm() {
    viewModel.DoctorloginWithFirebaseAuth(
        emailController.text, passwordController.text);
  }

  @override
  void goToProfilePage(DoctorDataBase doctorDataBase) {
    // go to home screen
    Provider.of<MyProvider>(context, listen: false);
    Navigator.pushReplacementNamed(context, ClinicProfile.routeName, arguments: true);
  }
  @override
  void initState() {
    super.initState();
    viewModel.navigator = this;
  }

  @override
  doctorloginViewModel initViewModel() {
    return doctorloginViewModel();
  }
}
