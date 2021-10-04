class User{

  String name;
  String phone;
  String email;
  String password;
  bool active;
  String imageUrl;


  User(){
    name = "";
    phone = "";
    email = "";
    active = false;
    imageUrl = "";
  }
  User.init({this.name, this.phone, this.email, this.active, this.imageUrl});



  // factory constructor uses another constructor to create and return object
  factory User.fromDocument(Map<String, dynamic> document){
    return User.init(name: document['name'], phone: document['phone'],
        email: document['email'], active: document['active'], imageUrl: document['imageURL']);
  }

  Map<String, dynamic> toMap(){
    return{
      "name": name,
      "phone": phone,
      "email": email,
      "active": active,
      "imageUrl": imageUrl,
    };

  }

}

