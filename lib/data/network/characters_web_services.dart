import 'package:dio/dio.dart';

import '../../constants/strings.dart';

class CharactersWebServices {
  late Dio dio;
  CharactersWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: Duration(seconds: 60), // 60 seconds
      receiveTimeout: Duration(seconds: 60), // 60 seconds
    );
    dio = Dio(options);
  }

  Future<List<dynamic>> getAllCharacters() async {
    try {
      final response = await dio.get('character');
      return response.data['results'];
    } catch (e) {
      return [];
    }
  }
}
