import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wanderer/providers/great_places.dart';
import 'package:wanderer/screens/add_place.dart';
import 'package:wanderer/screens/place_detail.dart';

class PlacesList extends StatelessWidget {
  const PlacesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Places"),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlace.routeName);
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: Center(
        child: FutureBuilder(
          future: Provider.of<GreatPlaces>(context, listen: false)
              .fetchAndSetPlaces(),
          builder: (ctx, snapshot) =>
              snapshot.connectionState == ConnectionState.waiting
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Consumer<GreatPlaces>(
                      child: Center(
                        child: Text("No places yet, start adding some"),
                      ),
                      builder: (ctx, greatPlaces, Widget? ch) =>
                          greatPlaces.items.length <= 0
                              ? ch!
                              : ListView.builder(
                                  itemCount: greatPlaces.items.length,
                                  itemBuilder: (ctx, i) => ListTile(
                                    leading: CircleAvatar(
                                      backgroundImage:
                                          FileImage(greatPlaces.items[i].image),
                                    ),
                                    title: Text(greatPlaces.items[i].title),
                                    subtitle: Text(greatPlaces.items[i].location!.address!),
                                    onTap: () {
                                      Navigator.of(context).pushNamed(PlaceDetails.routeName,
                                      arguments: greatPlaces.items[i].pId);// Detail page
                                    },
                                  ),
                                ),
                    ),
        ),
      ),
    );
  }
}
