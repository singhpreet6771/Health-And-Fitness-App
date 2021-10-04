import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_app/animations/simple-animation.dart';
import 'package:flutter/material.dart';
import 'package:fitness_app/utility/utils.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

bool checkUserInFirebaseAuth() {
  // In case user has logged in or registered, FirebaseAuth Module saves that information locally on the device as token
  FirebaseAuth auth = FirebaseAuth.instance;
  if(auth.currentUser != null) {
    Utils.UID = auth.currentUser.uid;
    return true;
  }else{
    return false;
  }
}

navigate(BuildContext context, String route){
  Future.delayed(
      Duration(seconds: 3),
          (){
        Navigator.pushReplacementNamed(context, route);
      }
  );
}

class AppSplashPage extends StatefulWidget{

  @override
  _AppSplashPageState createState() => _AppSplashPageState();
}

class _AppSplashPageState extends State<AppSplashPage> {
  bool internet = true;

  @override
  void initState() {
    super.initState();

    Utils.isInternetConnected().then((bool value) {
      print("Boolean Internet State is: $value");
        setState(() {
          internet = value;
        });

    });
  }
  @override
  Widget build(BuildContext context) {

    if(internet == true)
      {
        if(checkUserInFirebaseAuth()){ // UID is not empty -> i.e. User has either logged in or registered
          navigate(context, "/home");
        }else{
          navigate(context, "/login");
        }
        var size = MediaQuery.of(context).size;
        return Scaffold(

          backgroundColor: Theme.of(context).accentColor,
          body: Stack(
            children: <Widget>[
              Container(
                // Here the height of the container is 45% of our total height
                height: size.height,
                decoration: BoxDecoration(
                  color: Colors.white
              )
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    FadeAnimation(1.2,Image.asset('assets/app_icon.png')),
                    FadeAnimation(1.4,SpinKitRipple(color: Colors.deepOrange[200], size: 95.0,)),
                  ],
                ),
              ),
            ],
          ),
        );
      }
    else{
      return Scaffold(
        body: Center(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.signal_wifi_off,
                    color: Colors.redAccent,
                    size: 80,
                  ),
                  Text("Seems Like You Are Not Connected to Internet"),
                  Text("Please Connect to Internet and Try Again"),
                ],
              ),
            )),
      );
    }


  }
}