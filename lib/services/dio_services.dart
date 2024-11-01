import 'package:dio/dio.dart';

class DioServices {
  static void fetchData() async {
    var dio = Dio();

    try {
      var response = await dio.get("https://jsonplaceholder.typicode.com/posts/");
      print(response.data);
    } catch (e) {
      print(e);
    }
  }
}