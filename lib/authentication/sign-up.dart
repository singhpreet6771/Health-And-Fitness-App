import 'package:fitness_app/animations/simple-animation.dart';
import 'package:fitness_app/constants/constants.dart';
import 'package:fitness_app/model/user.dart' as u; // alias name to the user.dart since we have same class in user.dart and also in firebase_auth.dart
import 'package:fitness_app/utility/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class SignUpPage extends StatefulWidget{
  createState()=>_SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  bool internet = false;

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
    return Scaffold(
        resizeToAvoidBottomInset: true,
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
        body: SingleChildScrollView(

          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 40),
            height: MediaQuery.of(context).size.height*0.75,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    FadeAnimation(1, Text("Sign up", style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold
                    ),)),
                    SizedBox(height: 20,),
                    FadeAnimation(1.2, Text("Create an account, It's free", style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey[700]
                    ),)),
                  ],
                ),
               Form(
                 key: formKey,
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    FadeAnimation(1.2,Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        TextFormField(
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: "Enter Name",
                            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                                borderSide: BorderSide(color: Colors.black)
                            ),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)
                            ),
                          ),

                          controller: nameController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Please Enter Name"; // return error message
                            }
                            return null; // here no error message
                          },
                        ),
                      ],
                    )
                    ),
                    SizedBox(height: 10.0,),
                    FadeAnimation(1.3,Column(
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
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Please Enter Email"; // return error message
                            } else {
                              if (!value.contains("@") && !value.contains(".")) {
                                // implement regex to check if email is correctly entered or not
                                return "Email is not Valid";
                              }
                            }
                            return null; // here no error message
                          },
                        ),
                      ]
                    )
                    ),
                    SizedBox(height: 10.0,),
                    FadeAnimation(1.2,Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        TextFormField(

                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: "Enter Phone Number",
                            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: BorderSide(color: Colors.black)
                            ),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)
                            ),
                          ),

                          controller: phoneController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Please Enter Phone Number"; // return error message
                            }
                            return null; // here no error message
                          },
                        ),
                      ],
                    )
                    ),
                    SizedBox(height: 10.0,),
                    FadeAnimation(1.4,Column(
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
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)
                              ),
                            ),
                            controller: passwordController,
                            // Implement a functionality in the right of TextFormField to show/hide the Password
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Please Enter Password"; // return error message
                              } else {
                                if (value.length <= 5) {
                                  return "Password should be min 6 characters";
                                }
                              }
                              return null; // here no error message
                            },
                          ),
                        ]
                    )
                    ),
          ]
        ),
               ),
                FadeAnimation(1.5, Container(
                  child: MaterialButton(
                    minWidth: double.infinity,
                    height: 60,
                    onPressed: () async{
                      print("Registration Started");
                      if (formKey.currentState.validate()) {
                        // if no errors :)
                        String message = await registerUser(emailController.text, passwordController.text, phoneController.text);
                        print("Message is: $message");
                      }
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
                    ),
                    ),
                  ),
                )
                ),
                ],
              ),
          )
        )

    );
  }

  Future<String> registerUser(String email, String password, String phone) async{
    FirebaseAuth auth = FirebaseAuth.instance;
    UserCredential value = await auth.createUserWithEmailAndPassword(email: email, password: password);
    // User -> is from FirebaseAuth Library
    if(value.user.uid.isNotEmpty) {
      User user = value.user;
      Utils.UID = user.uid; // We have now UID of the registered User
      u.User uRef = u.User.init(
          name: nameController.text, phone:phoneController.text ,email: emailController.text, active: true);
      String message = saveUserInFireStore(uRef);
      print("Message: $message");
      Navigator.pushReplacementNamed(context, "/home");
      return "User Registered and Saved";
    }else{
      return "Something Went Wrong";
    }
  }

  String saveUserInFireStore(u.User user){ // u.User means User class from user.dart and not from firebase_auth.dart
    // we get the reference to the Cloud FireStore DataBase
    FirebaseFirestore db = FirebaseFirestore.instance;
    db.collection("users").doc(Utils.UID).set(user.toMap());
    return "User Saved";
  }

}