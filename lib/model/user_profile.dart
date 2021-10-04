import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness_app/constants/constants.dart';
import 'package:fitness_app/model/user.dart' as u;
import 'package:fitness_app/utility/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Future<u.User> fetchUserDetails() async{
  FirebaseFirestore db = FirebaseFirestore.instance;
  print("UID is ${Utils.UID}");
  DocumentSnapshot documentSnapshot = await db.collection(Constants.USERS_COLLECTION).doc(Utils.UID).get();
  u.User user = u.User.fromDocument(documentSnapshot.data());
  return user;
}

uploadImageToFirebaseStorage(String path) async{

  // Create the File Object to be Uploaded
  File file = File(path);

  // Obtain Reference to Firebase Storage
  FirebaseStorage storageReference = FirebaseStorage.instance;
  Reference profilePicsReference = storageReference.ref().child("profile-pics/");

  // Upload the Image
  // In order to monitor the file upload completion we will use StorageTaskSnapshot
  UploadTask uploadTask = profilePicsReference.child("profile_pic_${Utils.UID}.jpg").putFile(file);

  // If no errors get the URL of the Image which we just uploaded :)
    String profileImageURL = await (await uploadTask).ref.getDownloadURL(); // Get the URL of the Uploaded Image :)
    FirebaseFirestore db = FirebaseFirestore.instance;
    db.collection(Constants.USERS_COLLECTION).doc(Utils.UID).update({"imageURL": profileImageURL}).then((value){
      print("Image Uploaded and URL Saved :)");
    });
}


class UserProfilePage extends StatefulWidget {
  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {

  // user as reference points to a default User Object
  u.User user = u.User();

  @override
  void initState() {
    super.initState();
    fetchUserDetails().then((u.User value){
      setState(() {
        user = value; // refresh i.e. re execute the build function to update UI
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, "/home");
          },
          icon: Icon(Icons.arrow_back_ios, size: 20, color: Colors.black,),
        ),
        title: Text("Your Details", style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 25, color: Colors.deepOrange[400], fontFamily: 'Rubik', ),),
      ),
      body: Stack(
        children:<Widget>[
          Container(
            // Here the height of the container is 45% of our total height
            height: size.height,
            decoration: BoxDecoration(
              color: Colors.white
            ),
          ),
          ListView(
            padding: EdgeInsets.all(20.0),
            children: <Widget>[
              SizedBox(height: 5.0,),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage: user.imageUrl!=null ? NetworkImage(user.imageUrl) : AssetImage("assets/app_icon.png"),
                        radius: 50,
                      ),
                      onTap: () async{
                        //await ImagePicker.platform.pickImage(source: ImageSource.camera);
                        PickedFile pickedFile = await ImagePicker.platform.pickImage(source: ImageSource.gallery);
                        uploadImageToFirebaseStorage(pickedFile.path); // give the path of the picked image :)
                      },
                    ),
                    Spacer(),
                        Column(
                          children: [
                            Text("Name:  ${user.name}", style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 15, color: Colors.blueGrey[600], fontFamily: 'Rubik', ),),
                            SizedBox(height: 10.0,),
                            Text("Email:  ${user.email}", style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 15, color: Colors.blueGrey[600], fontFamily: 'Rubik', ),),
                            SizedBox(height: 10.0,),
                            user.phone == null ? Text("", style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 15, color: Colors.blueGrey[600], fontFamily: 'Rubik', ),) : Text("Phone:  ${user.phone}", style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 15, color: Colors.blueGrey[600], fontFamily: 'Rubik', ),),
                            SizedBox(height: 10.0,),
                            MaterialButton(
                              // minWidth: double.infinity,
                              height: 30,
                              color: Colors.deepOrange[200],
                              child: Text("Change Profile Picture", style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 15, color: Colors.blueGrey[600], fontFamily: 'Rubik', ),),
                              onPressed: ()async{
                                //await ImagePicker.platform.pickImage(source: ImageSource.camera);
                                PickedFile pickedFile = await ImagePicker.platform.pickImage(source: ImageSource.gallery);
                                uploadImageToFirebaseStorage(pickedFile.path);
                              },
                              elevation: 10,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: Colors.black
                                ),
                                borderRadius: BorderRadius.circular(50),

                              ),
                            ),
                          ],
                        ),
                  ],
                ),
              SizedBox(height: 20.0,),
              Container(
                  height: size.height*0.03,
                  child: Text("Settings", style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 25, color: Colors.deepOrange[400], fontFamily: 'Rubik', ),)
              ),
              Divider(thickness: 2.0,),
              SizedBox(height: 15.0,),
              ListTile(
                leading: Icon(Icons.person, color: Colors.deepOrange[400],),
                title: Text("Manage Profile", style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 18, color: Colors.blueGrey[600], fontFamily: 'Rubik', ),),
                subtitle: Text("Update Data for your Profile"),
                trailing: Icon(Icons.keyboard_arrow_right, color: Colors.deepOrange[400],),
                onTap: (){
                  Navigator.pushNamed(context, "/comingsoon");
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.local_fire_department_sharp, color: Colors.deepOrange[400],),
                title: Text("Manage Workouts", style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 18, color: Colors.blueGrey[600], fontFamily: 'Rubik', ),),
                subtitle: Text("Add or Remove Workouts"),
                trailing: Icon(Icons.keyboard_arrow_right, color: Colors.deepOrange[400],),
                onTap: (){
                  Navigator.pushNamed(context, "/home");
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.help,  color: Colors.deepOrange[400],),
                title: Text("Help & Assist", style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 18, color: Colors.blueGrey[600], fontFamily: 'Rubik', ),),
                subtitle: Text("FAQ's about the App and Usage"),
                trailing: Icon(Icons.keyboard_arrow_right, color: Colors.deepOrange[400],),
                onTap: (){
                  Navigator.pushNamed(context, "/comingsoon");

                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.import_contacts,  color: Colors.deepOrange[400],),
                title: Text("Terms & Conditions", style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 18, color: Colors.blueGrey[600], fontFamily: 'Rubik', ),),
                subtitle: Text("We are transparent with what we do"),
                trailing: Icon(Icons.keyboard_arrow_right, color: Colors.deepOrange[400],),
                onTap: (){
                  Navigator.pushNamed(context, "/comingsoon");

                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.account_box, color: Colors.deepOrange[400],),
                title: Text("Log Out", style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 18, color: Colors.blueGrey[600], fontFamily: 'Rubik', ),),
                subtitle: Text("Log Out your account from App"),
                trailing: Icon(Icons.keyboard_arrow_right, color: Colors.deepOrange[400],),
                onTap: (){
                  // Here Firebase will remove the User token which was saved locally on the device when user registered or logged in
                  // Hence, next time in splash FirebaseUser will be null after signout :)
                  FirebaseAuth.instance.signOut();
                  Navigator.pushReplacementNamed(context, "/"); // Take the user back to splash page again
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}

