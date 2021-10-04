import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness_app/animations/simple-animation.dart';
import 'package:fitness_app/constants/constants.dart';
import 'package:flutter/material.dart';


class DetailDietScreen extends StatefulWidget {
  String dietID;
  DetailDietScreen({Key key, @required this.dietID}) : super(key: key);
  @override
  _DetailDietScreenState createState() => _DetailDietScreenState();
}

class _DetailDietScreenState extends State<DetailDietScreen> {
  @override
  Widget build(BuildContext context) {
    Future<Map<String, dynamic>> fetchDietData() async{

      FirebaseFirestore db = FirebaseFirestore.instance;
      DocumentReference documentReference = db.collection("diet-plans").doc(widget.dietID);
      DocumentSnapshot documentSnapshot = await documentReference.get();

      Map<String, dynamic> document = documentSnapshot.data();

      print("DOCUMENT: ${document.toString()}");

      return document; // contains information of entire restaurant
    }
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, "/diet");
          },
          icon: Icon(Icons.arrow_back_ios, size: 20, color: Colors.black,),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            height: size.height,
            decoration: BoxDecoration(
                color: Colors.white
            ),
          ),
          FutureBuilder(
            future: fetchDietData(),
            builder: (BuildContext context, snapshot){
              if (snapshot.hasError) return Center(child: Text("Something Went Wrong"),);
              return snapshot.hasData ? Dishes(diet: snapshot.data)
                  : Center(child: CircularProgressIndicator(),);
            },
          ),
        ],
      ),
    );

  }
}



class Dishes extends StatefulWidget {

  Map<String, dynamic> diet;

  Dishes({Key key, @required this.diet}) : super(key: key);

  @override
  _DishesState createState() => _DishesState();
}

class _DishesState extends State<Dishes> {
  @override
  Widget build(BuildContext context) {

    return ListView.separated(
      itemCount: widget.diet['basics'].length,
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.all(8.0),
          child: Container(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(),
                FadeAnimation(1,Text(widget.diet['basics'][index]['name'], style: Theme.of(context)
                    .textTheme
                    .display1
                    .copyWith(fontWeight: FontWeight.w900, color: Colors.black87))),
                SizedBox(height: 20),
                FadeAnimation(1.6,Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  children: <Widget>[
                    SeassionCard2(
                      seassionNum: 1,
                      isDone: true,
                      press: () {},
                    ),
                    SeassionCard2(
                      seassionNum: 2,
                      press: () {},
                    ),
                    SeassionCard2(
                      seassionNum: 3,
                      press: () {},
                    ),
                    SeassionCard2(
                      seassionNum: 4,
                      press: () {},
                    ),
                  ],
                )),
                SizedBox(height: 30),
                FadeAnimation(1.8,Row(
                  children: [
                    Icon(Icons.label_important_outline , color: Colors.deepOrange[200],),

                    Text(
                      "IMPORTANT : -",
                      style: Theme.of(context).textTheme.title.copyWith(fontWeight: FontWeight.bold, color: Colors.black87),
                    ),
                  ],
                )),
                SizedBox(height: 10),
                FadeAnimation(2,Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                  padding: EdgeInsets.all(10),
                  height: 90,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(13),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 17),
                        blurRadius: 23,
                        spreadRadius: -13,
                        color: Colors.deepOrange[200],
                      ),
                    ],
                  ),
                  child: Row(
                    children: <Widget>[
                      Image.network(widget.diet['basics'][index]['imageURL']),
                      SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Basic 1",
                              style: Theme.of(context).textTheme.subtitle,
                            ),
                            Text(widget.diet['basics'][index]['basic1']),
                          ],
                        ),
                      ),

                    ],
                  ),
                )),

                SizedBox(height: 10),
                FadeAnimation(2.2,Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                  padding: EdgeInsets.all(10),
                  height: 90,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(13),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 17),
                        blurRadius: 23,
                        spreadRadius: -13,
                        color: Colors.deepOrange[200],
                      ),
                    ],
                  ),
                  child: Row(
                    children: <Widget>[
                      Image.network(widget.diet['basics'][index]['imageURL']),
                      SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Basic 2",
                              style: Theme.of(context).textTheme.subtitle,
                            ),
                            Text(widget.diet['basics'][index]['basic2']),
                          ],
                        ),
                      ),

                    ],
                  ),
                )),

                SizedBox(height: 10),
                FadeAnimation(2.4,Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                  padding: EdgeInsets.all(10),
                  height: 90,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(13),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 17),
                        blurRadius: 23,
                        spreadRadius: -13,
                        color: Colors.deepOrange[200],
                      ),
                    ],
                  ),
                  child: Row(
                    children: <Widget>[
                      Image.network(widget.diet['basics'][index]['imageURL']),
                      SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Basic 3",
                              style: Theme.of(context).textTheme.subtitle,
                            ),
                            Text(widget.diet['basics'][index]['basic3']),
                          ],
                        ),
                      ),

                    ],
                  ),
                )),
                SizedBox(height: 20),

                Padding(padding: EdgeInsets.all(4.0),),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return Divider();
      },

    );
  }
}

class SeassionCard2 extends StatelessWidget {
  final int seassionNum;
  final bool isDone;
  final Function press;
  const SeassionCard2({
    Key key,
    this.seassionNum,
    this.isDone = false,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(13),
        child: Container(
          width: constraint.maxWidth / 2 -
              10, // constraint.maxWidth provide us the available with for this widget
          // padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(13),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 17),
                blurRadius: 23,
                spreadRadius: -13,
                color: kShadowColor,
              ),
            ],
          ),
          child: Material(
            shape: RoundedRectangleBorder(
                side: BorderSide(
                    color: Colors.black45
                )
            ),
            // color: Colors.transparent,
            child: InkWell(
              onTap: press,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 42,
                      width: 43,
                      decoration: BoxDecoration(
                        color: isDone ? Colors.deepOrange[200] : Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.deepOrange[200]),
                      ),
                      child: Icon(
                        Icons.play_arrow,
                        color: isDone ? Colors.white : Colors.deepOrange[200],
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Meal $seassionNum",
                      style: Theme.of(context).textTheme.subtitle,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
