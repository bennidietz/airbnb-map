import 'dart:convert';

import 'package:airbnb_map/network/apis/google_sheet_api.dart';
import 'package:airbnb_map/network/model/category.dart';
import 'package:airbnb_map/network/model/data.dart';

import '../../_keys.dart';
import '../../injection.dart';
import '../model/place.dart';

abstract class GoogleSheetsRepository {
  Future<List<MyPlace>> getData();
}

class GoogleSheetsRepositoryImpl implements GoogleSheetsRepository {
  final GoogleSheetApi googleSheetApi;

  GoogleSheetsRepositoryImpl({required this.googleSheetApi});

  @override
  Future<List<MyPlace>> getData() async {
    List<MyPlace> list = [];

    var sheetId = '1WV_VULgUyWGN3cgVX-gADiZ4n9Tc3azVA7NYo5opkCY';

    var categories = (await googleSheetApi.get(sheetId, 'Category', kGoogleMapsApiKey))['values'] as List;

    for (var i = 0; i < categories.length; i++) {
      if (sl<GlobalData>().categories.where((element) => element.id == categories[i][0]).isEmpty) {
        sl<GlobalData>().categories.add(PlaceCategory(categories[i][0], categories[i][2], categories[i][1]));
      }
    }

    var data = (await googleSheetApi.get(sheetId, 'Dortmund', kGoogleMapsApiKey))['values'] as List;
    for (var i = 0; i < data.length; i++) {
      List<String> coordinates = data[i][4].split(', ');
      if (coordinates.length > 1 && data[i] is List && (data[i] as List).length > 3) {
        var latitude = double.tryParse(coordinates[0]);
        var longitude = double.tryParse(coordinates[1]);
        if (latitude != null && longitude != null) {
          list.add(MyPlace(
            name: data[i][0],
            category: sl<GlobalData>().categories.where((element) => element.id == data[i][1]).firstOrNull,
            latitude: latitude,
            longitude: longitude,
            description: data[i][2],
            imageUrl: data[i][3],
            icon: data[i][5],
          ));
        }
      }
    }
    sl<GlobalData>().myPlaces = list;
    return list;
  }
}
