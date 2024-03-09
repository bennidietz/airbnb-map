import 'package:airbnb_map/network/apis/google_sheet_api.dart';
import 'package:airbnb_map/network/model/data.dart';
import 'package:airbnb_map/network/repository/google_sheet_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance; // = service locator

/// factory = every time a new instance
/// singleton = only one instance for the whole app
Future<void> initInjections() async {
  /// scaffold messenger key
  sl.registerLazySingleton<GlobalKey<ScaffoldMessengerState>>(() => GlobalKey<ScaffoldMessengerState>());

  Dio googleSheetDio = Dio();

  sl.registerLazySingleton(() => GoogleSheetApi(googleSheetDio, baseUrl: 'https://sheets.googleapis.com/v4'));

  sl.registerLazySingleton<GoogleSheetsRepository>(() => GoogleSheetsRepositoryImpl(googleSheetApi: sl()));

  sl.registerLazySingleton(() => GlobalData());
}
