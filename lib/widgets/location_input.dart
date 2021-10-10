import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:wanderer/screens/map_screen.dart';

import '../helpers/location_helper.dart';

class LocationInput extends StatefulWidget {

  final Function onSelectPlace;
  const LocationInput(this.onSelectPlace,{Key? key}) : super(key: key);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;

  void _showPreview( double lat, double lng)
  {
    final staticImageUrl = LocationHelper.generateLocationPreviewImage(
        latitude: lat, longitude: lng);
    setState(() {
      _previewImageUrl = staticImageUrl;
    });
  }

  Future<void> _getUserLocation() async {
    try {
      final locData = await Location().getLocation();
      _showPreview(locData.latitude!, locData.longitude!);
      widget.onSelectPlace(locData.latitude, locData.longitude);
    }catch(err)
    {
      Fluttertoast.showToast(msg: "Grant Access to Location",toastLength: Toast.LENGTH_SHORT);
      return;
    }

  }

  Future<void> _selectOnMap() async {
    final selectedLocation = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (ctx) => MapScreen(
          isSelecting: true,
        ),
      ),
    );

    if(selectedLocation==null) {
      return;
    }

    _showPreview(selectedLocation.latitude, selectedLocation.longitude);
    widget.onSelectPlace(selectedLocation.latitude, selectedLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 180,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          alignment: Alignment.center,
          child: _previewImageUrl == null
              ? Text('No location chosen')
              : Image.network(
                  _previewImageUrl!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton.icon(
              icon: Icon(Icons.location_on),
              onPressed: _getUserLocation,
              label: Text('Current Location'),
              style:
                  TextButton.styleFrom(primary: Theme.of(context).primaryColor),
            ),
            TextButton.icon(
              icon: Icon(Icons.map),
              onPressed: _selectOnMap,
              label: Text('Select location on Map'),
              style:
                  TextButton.styleFrom(primary: Theme.of(context).primaryColor),
            ),
          ],
        ),
      ],
    );
  }
}
