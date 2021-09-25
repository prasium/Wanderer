import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:wanderer/models/place.dart';

class GreatPlaces with ChangeNotifier {

  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void addPlace(String pickedTitle, File pickedImage,)
  {
    final newPlace = Place(
      pId: DateTime.now().toString(),
      image: pickedImage,
      location: null,
      title: pickedTitle,
    );
    _items.add(newPlace);
    notifyListeners();
  }

}