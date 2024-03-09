import 'package:airbnb_map/network/model/category.dart';

import 'model/place.dart';

const double defaultPadding = 20.0;

List<MyPlace> places = [
  MyPlace(
      latitude: 14.621,
      longitude: -61.004,
      name: "Strand A",
      description: "Ein wunderschöner Stand mit tollem Sand und einer klasse Aussicht auf den Berg.",
      category: PlaceCategory('beach', '🗺', 'Strand')),
  MyPlace(
      latitude: 14.6022,
      longitude: -61.0568,
      name: "Fort de France",
      description: "Toller Hafen",
      category: PlaceCategory('beach', '🗺', 'Strand')),
];
