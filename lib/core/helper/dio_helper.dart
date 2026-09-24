import 'package:dio/dio.dart';

class DioHelper {
  final Dio dio = Dio(BaseOptions(baseUrl: 'https://openlibrary.org/'));
  String errorMessage(Object e) {
    if (e is DioException) {
      print("Data: ${e.response?.data}");
      return e.response?.data["message"] ?? "Unknown error";
    } else {
      return 'something wrong';
    }
  }
}
