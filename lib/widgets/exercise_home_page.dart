import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness_app/animations/simple-animation.dart';
import 'package:fitness_app/screens/detailed_workout.dart';
import 'package:fitness_app/widgets/workout-filters.dart';
import 'package:flutter/material.dart';


class ExerciseHomePage extends StatefulWidget {
  @override
  _ExerciseHomePageState createState() => _ExerciseHomePageState();
}

class _ExerciseHomePageState extends State<ExerciseHomePage> {

  @override
  Widget build(BuildContext context) {

    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference collectionWorkouts = db.collection("workouts-angular");

    var size = MediaQuery.of(context).size; //this gonna give us total height and with of our device
    return Scaffold(
      body: Stack(
        children: <Widget>[
      Container(
      height: size.height,
        decoration: BoxDecoration(
            color: Colors.white
        ),
      ),
        Positioned(
          right: 30,
          width: 120,
          height: 180,
          child:  FadeAnimation(1.2,Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/app_icon.png')
                )
            ),
          )
          ),
        ),
      StreamBuilder<QuerySnapshot>(
        stream: collectionWorkouts.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {

          if(snapshot.hasError){
            return Center(
              child: Text("Something Went Wrong. Please Try Again !!"),
            );
          }

          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(
                child: CircularProgressIndicator()
            );
          }
          return
            SafeArea(
              child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
          SizedBox(height: 30.0,),
          FadeAnimation(1,Container(
          height: size.height *.06,

          child: Text("Welcome", style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 55, color: Colors.deepOrange[400], fontFamily: 'Rubik', fontWeight: FontWeight.w600,),)

          )),
          SizedBox(height: 10.0,),
          FadeAnimation(1,Container(
          height: size.height *.06,

          child: Text("Your Health Our Priority", style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 32, color: Colors.deepOrange[400], fontFamily: 'Rubik', ),)

          ),
          ),
          FadeAnimation(1.4,WorkoutFilters()),
            SizedBox(height: 10.0,),
          Expanded(
          child: FadeAnimation(1.6,GridView.count(
            crossAxisCount: 1,
            childAspectRatio: .85,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            children: snapshot.data.docs.map((DocumentSnapshot document) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(13),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(13),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(17, 5),
                        blurRadius: 3.0,
                        spreadRadius: 3.0,
                        color: Colors.blueGrey,
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Colors.deepOrange[300]
                      )
                        ),
                    child: InkWell(
                      onTap: (){
                        MaterialPageRoute route = MaterialPageRoute(builder: (context) => DetailWorkoutScreen(workoutID: document.id),);
                        Navigator.push(context, route);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: <Widget>[
                            Image.network(document.data()['imageURL']),
                            Spacer(),
                            Text(document.data()['name'],
                              textAlign: TextAlign.center, style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 25),
                            ),
                            Text("Ratings | ${document.data()['ratings'].toString()}",
                              textAlign: TextAlign.center, style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          )
          )
          )
          ]
          )
          )
            );
        },
      )
        ]
      )
      );
  }
}
