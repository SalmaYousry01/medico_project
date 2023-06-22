import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:grad_project/Home_layout/Allergies/allergy.dart';
import 'package:grad_project/Home_layout/measurements/measurments.dart';
import 'package:grad_project/Home_layout/medicine/medicine_screen.dart';
import 'package:grad_project/Home_layout/reminder/reminder.dart';
import 'package:grad_project/Home_layout/your_doctor/All_Doctor.dart';
import 'package:grad_project/Home_layout/your_doctor/Your_doctor.dart';
import 'package:grad_project/Home_layout/your_doctor/single_doctor_widget.dart';
import 'package:grad_project/Profile/clinicProfile.dart';
import 'package:grad_project/Home_layout/test/test_screen.dart';
import 'package:grad_project/doctor_layout/all_patients/All_Patient.dart';
import 'package:grad_project/doctor_layout/doctor_navbar.dart';
import 'package:grad_project/first_screen/splash_screen.dart';
import 'package:grad_project/view_only_patient/allergy_view/allergy_view.dart';
import 'package:grad_project/view_only_patient/medicine_view/medicine_view.dart';
import 'package:grad_project/view_only_patient/prescription_view/prescription_view/prescription_view.dart';
import 'package:grad_project/view_only_patient/test_view/test_view.dart';
import 'package:grad_project/view_only_patient/view_only_patient_view.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:timezone/data/latest.dart';
import 'Home_layout/family_history/familyhistory.dart';
import 'Home_layout/notes/note_page.dart';
import 'Home_layout/prescription/pateint_uploaded_prescriptions/patient_prescreption.dart';
import 'Home_layout/reminder/notification_service.dart';
import 'Home_layout/your_doctor/single_doctor_clinic_profile.dart';
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
import 'package:timezone/data/latest.dart' as tz;

FlutterLocalNotificationsPlugin notificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initializeTimeZones();
  AndroidInitializationSettings androidSettings =
      AndroidInitializationSettings("@mipmap/ic_launcher");
  DarwinInitializationSettings iosSetting = DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestCriticalPermission: true,
    requestSoundPermission: true,
  );
  InitializationSettings initializationSettings =
      InitializationSettings(android: androidSettings, iOS: iosSetting);

  bool? initialized = await notificationsPlugin.initialize(
      initializationSettings, onDidReceiveNotificationResponse: (response) {
    log(response.payload.toString());
  });
  log("Notifications: $initialized");
  NotificationService().initNotification();
  tz.initializeTimeZones();
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
      initialRoute: SplashScreen.routeName,
      onGenerateRoute: (settings) {
        var routes = <String, WidgetBuilder>{
          SplashScreen.routeName:(context) => SplashScreen(),
          PatientSignup.routeName: (context) => PatientSignup(),
          DoctorSignup.routeName: (context) => DoctorSignup(),
          Firstpage.routeName: (context) => Firstpage(),
          home.routeName: (context) => home(),
          ProfileTab.routeName: (context) => ProfileTab(),
          navv.routeName: (context) => navv(),
          PatientLogin.routeName: (context) => PatientLogin(),
          DoctortLogin.routeName: (context) => DoctortLogin(),
          ClinicProfile.routeName: (c) =>
              ClinicProfile(settings.arguments as bool),
          TestScreen.routeName: (c) => TestScreen(),
          PatientPrescription.routeName: (c) => PatientPrescription(),
          MedicineScreen.routeName: (c) => MedicineScreen(),
          NotesPage.routeName: (c) => NotesPage(),
          MedicineScreen.routeName: (c) => MedicineScreen(),
          reminder1.routeName: (c) => reminder1(),
          allergy1.routeName: (c) => allergy1(),
          AllDoctor.routeName: (c) => AllDoctor(),
          SingleDoctorClinicProfile.routeName: (context) =>
              SingleDoctorClinicProfile(
                  settings.arguments as DoctorClinicModel),
          YourDoctors.routeName: (c) => YourDoctors(),
          Measurments.routeName: (c) => Measurments(),
          AllPatient.routeName: (c) => AllPatient(),
          ViewOnlyPatientView.routeName: (c) => ViewOnlyPatientView(),
          TestView.routeName: (c) => TestView(),
          AllergyView.routeName: (c) => AllergyView(),
          MedicineView.routeName: (c) => MedicineView(),
          PrescriptionView.routeName: (c) => PrescriptionView(),
          FamilyHistory.routeName: (c) => FamilyHistory(),
          navdoc.routeName: (c) => navdoc()
        };
        WidgetBuilder? builder = routes[settings.name];
        return MaterialPageRoute(builder: (ctx) => builder!(ctx));
      },
      // home: AllDoctor(),
      debugShowCheckedModeBanner: false,
    );
  }
}
