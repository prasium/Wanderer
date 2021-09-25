import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wanderer/providers/great_places.dart';
import 'package:wanderer/screens/add_place.dart';
import 'package:wanderer/screens/places_list.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: GreatPlaces(),
      child: MaterialApp(
        title: "Wanderer",
        theme: ThemeData(
          primarySwatch: Colors.cyan,
          accentColor: Colors.pinkAccent,
        ),
        home: PlacesList(),
        routes: {
          AddPlace.routeName: (ctx)=> AddPlace(),
        },
      ),
    );
  }
}



