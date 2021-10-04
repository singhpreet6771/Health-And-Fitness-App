import 'package:flutter/material.dart';

class HealthCalPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, "/home");
          },
          icon: Icon(Icons.arrow_back_ios, size: 20, color: Colors.black,),
        ),
        title: Text("Health Calculators", style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 25, color: Colors.deepOrange[400], fontFamily: 'Rubik', ),),
      ),
      body: Center(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.precision_manufacturing_outlined,
                  color: Colors.deepOrange[200],
                  size: 80,
                ),
                Text("Your Health Calculators are coming very soon"),
                Text("Till Then Start you fitness journey with our programs"),
              ],
            ),
          )),
    );
  }
}

