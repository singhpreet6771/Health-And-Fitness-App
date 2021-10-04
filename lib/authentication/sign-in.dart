import 'package:fitness_app/animations/simple-animation.dart';
import 'package:fitness_app/utility/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool internet = false;

  @override
  void initState() {
    super.initState();

    Utils.isInternetConnected().then((bool value) {
      print("Boolean Internet State is: $value");
      if (this.mounted){
        setState(() {
          internet = value;
        });
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          brightness: Brightness.light,
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios, size: 20, color: Colors.black,),
          ),
        ),
        body: Stack(
              children: <Widget>[
                Container(
          height: MediaQuery.of(context).size.height*0.65,
          width: double.infinity,
          child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      child: Column(
                        children: <Widget>[
                          FadeAnimation(1, Text("Login", style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold
                          ),)),
                          SizedBox(height: 20,),
                          FadeAnimation(1.2, Text("Login to your account", style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey[700]
                          ),
                          )
                          ),
                      ],
                      )
                    ),
                      SizedBox(height: 30.0,),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Form(
                          key: formKey,
                          child: Column(
                            children: <Widget>[
                              FadeAnimation(1.2,Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(height: 5,),
                                    TextFormField(
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        labelText: "Enter Email",
                                        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(30.0),
                                            borderSide: BorderSide(color: Colors.black)
                                        ),
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.black)
                                        ),
                                      ),
                                      controller: emailController,
                                      validator: (val) {
                                        if (val.isEmpty) {
                                          return "Please Enter Email"; // return error message
                                        }
                                        else {
                                          if (!val.contains("@") &&
                                              !val.contains(".")) {
                                            // implement regex to check if email is correctly entered or not
                                            return "Email is not Valid";
                                          }
                                        }
                                        return null; // here no error message
                                      },
                                    ),
                                  ],
                                ),

                              ),
                              SizedBox(height: 15.0,),
                              FadeAnimation(1.3, Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(height: 5,),
                                    TextFormField(
                                      obscureText: true,
                                      decoration: InputDecoration(
                                        labelText: "Enter password",
                                        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(30.0),
                                            borderSide: BorderSide(color: Colors.black)
                                        ),
                                        border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)
                                        ),
                                      ),
                                      controller: passwordController,
                                      // Implement a functionality in the right of TextFormField to show/hide the Password
                                      validator: (val) {
                                        if (val.isEmpty) {
                                          return "Please Enter Password"; // return error message
                                        }
                                        else {
                                          if (val.length <= 5) {
                                            return "Password should be min 6 characters";
                                          }
                                        }
                                        return null; // here no error message
                                      },
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                          // SizedBox(height: 5.0,),
                          FadeAnimation(1.4, Padding(
                            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 0),

                            child: Container(

                              child: MaterialButton(
                                minWidth: double.infinity,
                                height: 60,
                                color: Colors.deepOrange[200],
                                onPressed: () async {
                                  if (formKey.currentState.validate()) {
                                    // if no errors :)
                                    User user = await loginUser(emailController.text, passwordController.text);
                                    if (user.uid.isNotEmpty) {
                                      // Login is a Success
                                      print("Login Success");
                                      Navigator.pushReplacementNamed(context, "/home");
                                    } else {
                                      // Login is a Failure
                                      print("Login Failed");
                                    }
                                  }
                                },
                                // elevation: 0,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      color: Colors.black
                                  ),
                                  borderRadius: BorderRadius.circular(50),

                                ),
                                child: Text("Login", style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18
                                ),
                                ),

                              ),
                            ),
                          )
                          ),
                          FadeAnimation(1.5, Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("Don't have an account?", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),),
                              // Text("Sign up", style: TextStyle(
                              //     fontWeight: FontWeight.w600, fontSize: 18
                              // ),
                              // ),
                              FlatButton(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text("Sign Up", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),),
                                  onPressed: (){
                                    Navigator.pushReplacementNamed(context, "/signup");
                                  },
                              )
                            ],
                          )
                          ),
                        ],
                      ),
                    ),
              ],
            )


    );
  }

  Future<User> loginUser(String email, String password) {
    FirebaseAuth auth = FirebaseAuth.instance;
    auth.signInWithEmailAndPassword(email: email, password: password).then((UserCredential value) {
      // User -> is from FirebaseAuth Library
      User user = value.user;
      Utils.UID = user.uid; // We have now UID of the registered User
      return user;
    });
  }
}