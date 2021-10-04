import 'package:cloud_firestore/cloud_firestore.dart';

class Address{

  String adrsLine;
  String city;
  String state;
  String zipCode;
  String label;

  GeoPoint location;

  Address(){}

  Address.init({this.adrsLine, this.city, this.state, this.zipCode, this.label, this.location});

  Map<String, dynamic> toMap(){
    return{
      "adrsLine":adrsLine,
      "city": city,
      "state":state,
      "zipCode": zipCode,
      "label":label,
      "location": location
    };
  }

}