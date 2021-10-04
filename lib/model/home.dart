import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:fitness_app/model/user_profile.dart';
import 'package:fitness_app/widgets/diet_plan_page.dart';
import 'package:fitness_app/widgets/exercise_home_page.dart';
import 'package:fitness_app/animations/simple-animation.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget{

  createState ()=> _HomePageState();

}

class _HomePageState extends State<HomePage> {

  int index = 1;

  List<Widget> widgets = [
    // 0
    DietPlanPage(),
    // 1
    ExerciseHomePage(),
    // 2
    UserProfilePage(),
  ];

  // navItemClicked shall refresh the UI i.e. build the UI again with new value of Index
  void navItemClicked(int i) async{
    setState(() {
      index = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadeAnimation(1,Center(
        child: widgets.elementAt(index),// widgets[index]
      )),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.pushNamed(context, "/calculator");
          },
          child: Icon(Icons.stacked_bar_chart),
          backgroundColor: Colors.deepOrange[300],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: FadeAnimation(1.4,BubbleBottomBar(
        opacity: 0.2,
        backgroundColor: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16.0),
        ),
        currentIndex: index,
        hasInk: true,
        inkColor: Colors.black12,
        hasNotch: true,
        fabLocation: BubbleBottomBarFabLocation.end,
        onTap: navItemClicked,
        items: [
          BubbleBottomBarItem(
            backgroundColor: Colors.deepOrange[300],
            icon: Icon(
              Icons.emoji_food_beverage,
              color: Colors.black,
            ),
            activeIcon: Icon(
              Icons.emoji_food_beverage,
              color: Colors.deepOrange[300],
            ),
            title: Text('Diet', style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(fontSize: 15),),
          ),
          BubbleBottomBarItem(
            backgroundColor: Colors.deepOrange[300],
            icon: Icon(
              Icons.local_fire_department_sharp,
              color: Colors.black,
            ),
            activeIcon: Icon(
              Icons.local_fire_department_sharp,
              color: Colors.deepOrange[300],
            ),
            title: Text('Workouts', style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(fontSize: 15),),
          ),
          BubbleBottomBarItem(
            backgroundColor: Colors.deepOrange[300],
            icon: Icon(
              Icons.person_rounded,
              color: Colors.black,
            ),
            activeIcon: Icon(
              Icons.person_rounded,
              color: Colors.deepOrange[300],
            ),
            title: Text('Profile', style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(fontSize: 15),),
          ),
        ],
      )
    )
    );
  }
}