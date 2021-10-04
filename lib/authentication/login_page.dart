import 'package:flutter/material.dart';
import 'package:fitness_app/animations/simple-animation.dart';

class loginPage extends StatefulWidget {
  @override
  createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.blueGrey[300],
      body: Stack(
        children: <Widget>[
          Container(
            // Here the height of the container is 45% of our total height
            height: size.height,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
          ),
          SafeArea(
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      FadeAnimation(1, Text("Welcome", style: Theme.of(context)
                          .textTheme
                          .headline6
                          .copyWith(fontSize: 35),)),
                      SizedBox(height: 20,),
                      FadeAnimation(1.2, Text("Automatic identity verification which enables you to verify your identity",
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            .copyWith(fontSize: 18),)),
                    ],
                  ),
                  FadeAnimation(1.4, Container(
                    height: MediaQuery.of(context).size.height / 3,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/splash_page_img.png'),
                            fit: BoxFit.cover
                        )
                    ),
                  )),
                  Column(
                    children: <Widget>[
                      FadeAnimation(1.6, MaterialButton(
                        minWidth: double.infinity,
                        height: 60,
                        onPressed: () {
                          Navigator.pushNamed(context, "/signin");
                        },
                        color: Colors.deepOrange[200],
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: Colors.black
                            ),
                            borderRadius: BorderRadius.circular(50)
                        ),
                        child: Text("Login", style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18
                        ),),
                      )),
                      SizedBox(height: 20,),
                      FadeAnimation(1.8, Container(

                        child: MaterialButton(
                          minWidth: double.infinity,
                          height: 60,
                          onPressed: () {
                            Navigator.pushNamed(context, "/signup");
                          },
                          color: Colors.deepOrange[200],
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: Colors.black
                              ),
                              borderRadius: BorderRadius.circular(50)
                          ),
                          child: Text("Sign up", style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18
                          ),),
                        ),
                      ))
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}