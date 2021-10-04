import 'package:fitness_app/authentication/sign-in.dart';
import 'package:fitness_app/authentication/sign-up.dart';
import 'package:fitness_app/authentication/login_page.dart';
import 'package:fitness_app/authentication/splash_page.dart';
import 'package:fitness_app/model/home.dart';
import 'package:fitness_app/model/user_profile.dart';
import 'package:fitness_app/screens/detailed_workout.dart';
import 'package:fitness_app/widgets/coming-soon.dart';
import 'package:fitness_app/widgets/diet_plan_page.dart';
import 'package:fitness_app/widgets/health_calculators.dart';
import 'package:flutter/material.dart';


class FitnessApp extends StatefulWidget{

  @override
   createState() => _FitnessAppState();
}

class _FitnessAppState extends State<FitnessApp> {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      routes: {
        "/": (context) => AppSplashPage(),
        "/login": (context) => loginPage(),
        "/signup": (context) => SignUpPage(),
        "/signin": (context) => SignInPage(),
        "/home": (context) => HomePage(),
        "/meditation": (context) => DetailWorkoutScreen(),
        "/profile": (context) => UserProfilePage(),
        "/diet": (context) => DietPlanPage(),
        "/comingsoon": (context) => ComingSoonPage(),
        "/calculator": (context) => HealthCalPage(),

      },

      initialRoute: "/",


    );
  }
}