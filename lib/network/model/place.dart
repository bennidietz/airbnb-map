import 'package:airbnb_map/network/model/category.dart';

class MyPlace {
  final PlaceCategory? category;
  final String name;
  final String? from;
  final double latitude;
  final double longitude;
  final String description;
  final String? imageUrl;
  final String? website;
  final String? icon;

  MyPlace({
    required this.category,
    required this.name,
    this.from,
    required this.latitude,
    required this.longitude,
    required this.description,
    this.imageUrl,
    this.website,
    this.icon,
  });

  String get stringIcon => category?.icon ?? '🗺';
}
