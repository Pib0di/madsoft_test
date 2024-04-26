import 'package:dio/dio.dart';
import 'package:madsoft_test/core/models/json_parser.dart';
import 'package:retrofit/retrofit.dart';

part 'rest_client.g.dart';

@RestApi()
abstract class RestClient {
  factory RestClient(Dio dio) = _RestClient;

  @GET('https://json-parser.com/f5628f20/4.json')
  Future<JsonParser> getJsonParser();
}
