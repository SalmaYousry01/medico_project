import 'package:flutter/material.dart';
import 'package:grad_project/first_screen/first_page.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

class SplashScreen extends StatelessWidget {
  static const String routeName = "SplashScreen";

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        children: [
          Image.asset('assets/images/logo3.jpg',),
          SizedBox(height:20 ,),
          Text('Medico',style: TextStyle(fontSize: 50,fontWeight: FontWeight.bold,color: Color(0xFF2C698D),))],
      ),
      backgroundColor: Colors.white,
      nextScreen:Firstpage(),
      splashIconSize: 400,
      duration: 4000,
      splashTransition: SplashTransition.fadeTransition,
      animationDuration: const Duration(seconds: 1),

    );
  }
}