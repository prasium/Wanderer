import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:provider/provider.dart';
import 'package:wanderer/providers/great_places.dart';
import 'package:wanderer/screens/add_place.dart';
import 'package:wanderer/screens/places_list.dart';
import 'screens/place_detail.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Required by FlutterConfig
  await FlutterConfig.loadEnvVariables();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: GreatPlaces(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Wanderer",
        theme: ThemeData(
          primarySwatch: Colors.cyan,
          accentColor: Colors.pinkAccent,
        ),
        home: PlacesList(),
        routes: {
          AddPlace.routeName: (ctx)=> AddPlace(),
          PlaceDetails.routeName: (ctx)=>PlaceDetails(),
        },
      ),
    );
  }
}



