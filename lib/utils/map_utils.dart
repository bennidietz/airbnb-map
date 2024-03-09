import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../network/model/place.dart';

class MapUtils {
  MapUtils._();

  /*static Future<void> openMap(double latitude, double longitude) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }*/

  static List<Marker> getMarkers(List<MyPlace> myPlaces) {
    return myPlaces
        .map(
          (place) => Marker(
            point: LatLng(place.latitude, place.longitude),
            width: 60,
            height: 60,
            alignment: Alignment.topCenter,
            child: place.imageUrl != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Image.network(
                        place.imageUrl!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                : Text(
                    place.icon ?? place.category?.icon ?? '🗺',
                    style: const TextStyle(fontSize: 30),
                  ),
          ),
        )
        .toList();
  }
}
