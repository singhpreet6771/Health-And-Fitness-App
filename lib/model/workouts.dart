class Workouts{

  String name ;
  String description ;
  double duration;
  List<String> basics;
  bool active;
  String imageURL;



  Workouts(){
     name = "";
     description = "";
     duration = 0;
     basics = [];
     active = true;
     imageURL = "";
  }

  Workouts.init({this.name, this.description, this.duration, this.basics ,this.active, this.imageURL});



  // factory constructor uses another constructor to create and return object
  factory Workouts.fromDocument(Map<String, dynamic> document){
    return Workouts.init(name: document['name'], description: document['description'],
        duration: document['duration'], basics: document['basics'] ,active: document['active'], imageURL: document['imageURL']);
  }

  Map<String, dynamic> toMap(){
    return{
      "name": name,
      "description": description,
      "duration": duration,
      "basics": basics,
      "active": active,
      "imageURL": imageURL,
    };

  }

}

