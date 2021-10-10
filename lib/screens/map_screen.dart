import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../models/place.dart';
import 'package:flutter_config/flutter_config.dart';

final accessToken = FlutterConfig.get('API_TOKEN');
final mapboxUser = FlutterConfig.get('USER');

class MapScreen extends StatefulWidget {
  final Location initialLocation;
  final bool isSelecting;

  const MapScreen(
      {Key? key,
      this.initialLocation =
          const Location(longitude: -122.084, latitude: 37.422),
      this.isSelecting = false})
      : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  List<Widget> _actions = [];

  LatLng? _pickedLocation;

  void _selectLocation(tapPosition, LatLng position) {
    setState(() {
      _pickedLocation = position;
      _actions.add(
        IconButton(
          icon: Icon(
            Icons.check,
          ),
          onPressed: () => Navigator.of(context).pop(_pickedLocation),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Map'),
        actions: <Widget>[
          if (widget.isSelecting)
            IconButton(
              onPressed: _pickedLocation==null?null:() {
                Navigator.of(context).pop(_pickedLocation);
              },
              icon: Icon(Icons.check),
            ),
        ],
      ),
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(widget.initialLocation.latitude,
              widget.initialLocation.longitude),
          zoom: 16.0,
          onTap: widget.isSelecting ? _selectLocation : null,
        ),
        layers: [
          TileLayerOptions(
              urlTemplate:
                  'https://api.mapbox.com/styles/v1/$mapboxUser/ckul637y63ldg17q1pcullctn/tiles/256/{z}/{x}/{y}@2x?access_token=$accessToken',
              additionalOptions: {
                'accessToken': accessToken,
                'id': 'mapbox.mapbox-streets-v8',
              }),
          MarkerLayerOptions(
            markers: (widget.isSelecting&&_pickedLocation==null)
                ?[] :[
                    Marker(
                      width: 50.0,
                      height: 50.0,
                      point: _pickedLocation ??
                          LatLng(widget.initialLocation.latitude,
                              widget.initialLocation.longitude),
                      builder: (ctx) => Icon(
                        Icons.add_location,
                        color: Colors.red,
                        size: 50,
                      ),

                    ),
                  ],
          ),
        ],
      ),
    );
  }
}
