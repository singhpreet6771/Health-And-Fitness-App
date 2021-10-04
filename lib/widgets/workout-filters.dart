import 'package:flutter/material.dart';

class WorkoutFilters extends StatefulWidget {

  Function(String) update;


  @override
  _WorkoutFiltersState createState() => _WorkoutFiltersState();
}

class _WorkoutFiltersState extends State<WorkoutFilters> {
  @override
  Widget build(BuildContext context) {
    return
      Container(
          padding: EdgeInsets.all(8.0),
          height: 80,
          child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.all(8.0),
            children: [
              MaterialButton(
                child: Text(
                  "Latest", style: TextStyle(fontSize: 18.0,),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24.0),
                    side: BorderSide(color: Colors.blueGrey)
                ),
                color: Colors.deepOrange[100],
                onPressed: (){
                  // widget.update(Constants.TAG1);
                },
              ),
              Padding(padding: EdgeInsets.all(6.0),),
              MaterialButton(
                child: Text(
                  "Top 5", style: TextStyle(fontSize: 18.0,),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24.0),
                    side: BorderSide(color: Colors.blueGrey)
                ),
                color: Colors.deepOrange[100],
                onPressed: (){
                  // widget.update(Constants.TAG2);
                },
              ),
              Padding(padding: EdgeInsets.all(6.0),),
              MaterialButton(
                child: Text(
                  "Trending", style: TextStyle(fontSize: 18.0,),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24.0),
                    side: BorderSide(color: Colors.blueGrey)
                ),
                color: Colors.deepOrange[100],
                onPressed: (){
                  // widget.update(Constants.TAG3);
                },
              ),
              Padding(padding: EdgeInsets.all(6.0),),
              MaterialButton(
                child: Text(
                  "Exclusive", style: TextStyle(fontSize: 18.0,),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24.0),
                    side: BorderSide(color: Colors.blueGrey)
                ),
                color: Colors.deepOrange[100],
                onPressed: (){
                  // widget.update(Constants.TAG3);
                },
              ),
              Padding(padding: EdgeInsets.all(6.0),),
              MaterialButton(
                child: Text(
                  "Water", style: TextStyle(fontSize: 18.0,),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24.0),
                    side: BorderSide(color: Colors.blueGrey)
                ),
                color: Colors.deepOrange[100],
                onPressed: (){
                  // widget.update(Constants.TAG3);
                },
              ),
            ],
          )
      );
  }
}
