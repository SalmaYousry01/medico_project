import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:grad_project/Home_layout/calender/calender.dart';
import 'package:grad_project/Home_layout/medicine/medicine_screen.dart';
import 'package:grad_project/Home_layout/prescription/patient_prescreption.dart';
import 'package:grad_project/Profile/clinicProfile.dart';
import 'package:grad_project/Home_layout/test/test_screen.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'Home_layout/notes/note_page.dart';
import 'create_account/patient_signup.dart';
import 'package:provider/provider.dart';
import 'package:grad_project/create_account/doctor_signup.dart';
import 'first_screen/first_page.dart';
import 'package:grad_project/Home_layout/home.dart';
import 'package:grad_project/Home_layout/patient_profile/profile.dart';

import 'firebase_options.dart';
import 'package:grad_project/Home_layout/navv.dart';
import 'login/doctor_login.dart';
import 'login/patient_login.dart';
import 'myprovider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  var box = await Hive.openBox('notes');
  runApp(ChangeNotifierProvider(
      create: (context) => MyProvider(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return GetMaterialApp(
      theme: ThemeData(
        primaryColor: Colors.amber,
        // ignore: deprecated_member_use
        androidOverscrollIndicator: AndroidOverscrollIndicator.stretch,
      ),
      initialRoute: Firstpage.routeName,
      onGenerateRoute: (settings) {
        var routes = <String, WidgetBuilder>{
          PatientSignup.routeName: (context) => PatientSignup(),
          DoctorSignup.routeName: (context) => DoctorSignup(),
          Firstpage.routeName: (context) => Firstpage(),
          home.routeName: (context) => home(),
          ProfileTab.routeName: (context) => ProfileTab(),
          picker.routeName: (context) => picker(),
          navv.routeName: (context) => navv(),
          PatientLogin.routeName: (context) => PatientLogin(),
          DoctortLogin.routeName: (context) => DoctortLogin(),
          ClinicProfile.routeName:(c)=>ClinicProfile(settings.arguments as bool),
          TestScreen.routeName:(c)=>TestScreen(),
          PatientPrescription.routeName:(c)=>PatientPrescription(),
          MedicineScreen.routeName:(c)=>MedicineScreen(),
          NotesPage.routeName:(c)=>NotesPage()
        };
        WidgetBuilder? builder = routes[settings.name];
        return MaterialPageRoute(builder: (ctx) => builder!(ctx));
      },
    // home: ProfileTab(),
      debugShowCheckedModeBanner: false,
    );
  }
}

