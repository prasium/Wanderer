
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/great_places.dart';
import '../screens/map_screen.dart';

class PlaceDetails extends StatelessWidget {
  static const routeName = "/place-detail";
  const PlaceDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String? id = ModalRoute.of(context)!.settings.arguments as String?;
    final selectedPlace =
        Provider.of<GreatPlaces>(context, listen: false).findById(id!);
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedPlace.title),
      ),
      body: Column(
        children: [
          Container(
            height: 300,
            width: double.infinity,
            child: Image.file(
              selectedPlace.image,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            selectedPlace.location!.address!,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.blueGrey.shade800,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 10,),
          TextButton(
              onPressed: (){
                Navigator.of(context).push(
                  MaterialPageRoute(
                    fullscreenDialog: true,
                    builder: (ctx)=> MapScreen(
                    initialLocation: selectedPlace.location!,
                      isSelecting: false,
                  ),
                  ),
                );
              },
              child: Text('Open in Map'),
              style: TextButton.styleFrom(
                primary: Theme.of(context).accentColor,
              ),
          ),
        ],
      ),
    );
  }
}
