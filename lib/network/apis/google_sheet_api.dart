import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'google_sheet_api.g.dart';

@RestApi()
abstract class GoogleSheetApi {
  factory GoogleSheetApi(Dio dio, {String baseUrl}) = _GoogleSheetApi;

  @GET('/spreadsheets/{sheetId}/values/{tableName}?alt=json&key={apiKey}')
  Future<dynamic> get(
    @Path('sheetId') String sheetId,
    @Path('tableName') String tableName,
    @Path('apiKey') String apiKey,
  );
}
