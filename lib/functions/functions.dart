import 'package:dart_countries/dart_countries.dart';

//gets continent name by id
String getContinent(String id){
  String continent = countriesContinent[id];
  return continent;
}