import 'dart:io';

class Location{
  final double latitude;
  final double longitude;
  final String address;

  Location(this.address, {
   required this.latitude,
   required this.longitude,
});
}

class Place{
  final String pId;
  final String title;
  final Location location;
  final File image;

  Place({
   required this.pId,
   required this.title,
   required this.location,
   required this.image,
});
}