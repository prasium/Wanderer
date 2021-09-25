import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wanderer/providers/great_places.dart';
import 'package:wanderer/screens/add_place.dart';

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
        child: Consumer<GreatPlaces>(
          child: Center(
            child: Text("No places yet, start adding some"),
          ),
          builder: (ctx,greatPlace, ch)=> greatPlace.items.length<=0?
          ch : ListView.builder(itemCount:greatPlace.items.length,
              itemBuilder: (ctx,i)=> ListTile(
              leading: CircleAvatar(
                backgroundImage: FileImage(greatPlace.items[i].image),
              ),
                title: Text(greatPlace.items[i].title),
                onTap: (){

                },
              ),
          ),
        ),
      ),
    );
  }
}
