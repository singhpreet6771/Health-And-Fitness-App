import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness_app/animations/simple-animation.dart';
import 'package:fitness_app/screens/detailed_diet_plan.dart';

import 'package:fitness_app/widgets/workout-filters.dart';
import 'package:flutter/material.dart';


class DietPlanPage extends StatefulWidget {
  @override
  _DietPlanPageState createState() => _DietPlanPageState();
}

class _DietPlanPageState extends State<DietPlanPage> {

  @override
  Widget build(BuildContext context) {

    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference collectionWorkouts = db.collection("diet-plans");

    var size = MediaQuery.of(context).size; //this gonna give us total height and with of our device
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
          title: Text("Diet Plans", style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 25, color: Colors.deepOrange[400], fontFamily: 'Rubik', ),),
        ),
        body: Stack(
            children: <Widget>[
              Container(
                height: size.height,
                decoration: BoxDecoration(
                    color: Colors.white
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
                                  SizedBox(height: 10.0,),
                                  FadeAnimation(1.4,WorkoutFilters()),
                                  SizedBox(height: 20.0,),
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
                                                    MaterialPageRoute route = MaterialPageRoute(builder: (context) => DetailDietScreen(dietID: document.id),);
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
