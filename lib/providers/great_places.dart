import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:wanderer/helpers/db_helper.dart';
import 'package:wanderer/helpers/location_helper.dart';
import 'package:wanderer/models/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  Place findById(String id)
  {
    return _items.firstWhere((place) => place.pId==id);
  }

  void addPlace(
    String pickedTitle,
    File pickedImage,
    Location pickedLocation,
  ) async {
    final address = await LocationHelper.getPlaceAddress(
        pickedLocation.latitude, pickedLocation.longitude);

    final updatedLocation = Location(
        latitude: pickedLocation.latitude,
        longitude: pickedLocation.longitude,
        address: address);

    final newPlace = Place(
      pId: DateTime.now().toString(),
      image: pickedImage,
      location: updatedLocation,
      title: pickedTitle,
    );

    _items.add(newPlace);

    notifyListeners();
    DBHelper.insert('user_places', {
      'id': newPlace.pId,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'loc_lat': newPlace.location!.latitude,
      'loc_lng': newPlace.location!.longitude,
      'address': newPlace.location!.address!,
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData('user_places');
    _items = dataList
        .map(
          (item) => Place(
            pId: item['id'],
            title: item['title'],
            location: Location(
              latitude: item['loc_lat'],
              longitude: item['loc_lng'],
              address: item['address'],
            ),
            image: File(item['image']),
          ),
        )
        .toList();
    notifyListeners();
  }
}
