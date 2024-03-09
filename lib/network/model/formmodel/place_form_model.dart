import 'package:latlong2/latlong.dart';

import '../../errors/common_error.dart';
import '../category.dart';

class PlaceFormModel {
  String? title;
  String? description;
  LatLng? latLng;
  MyCategory? category;

  void setTitle(String title) {
    if (!validateText(title)) throw CommonError(message: "Der Titel ist nicht valide");
    this.title = title;
  }

  void setDescription(String description) {
    if (!validateText(description)) throw CommonError(message: "Die Beschreibung ist nicht valide");
    this.description = description;
  }

  void setLatLng(LatLng latlng) {
    latLng = latlng;
  }

  bool validateText(String text) => text.length > 3;

  bool validateData() {
    return title != null && description != null && latLng != null && validateText(title!) && validateText(description!);
  }
}
