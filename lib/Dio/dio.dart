import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:untitled2/model/news_information.dart';
import 'package:untitled2/widget/toast_message.dart';

class DioHttp {
  final Dio dio = Dio();

  Future<List<Articles>?> getHttp(String category) async {
    try {
      final response = await dio.get(
        dotenv.env['BASEURL']!,
        queryParameters: {
          'apiKey': dotenv.env['APIKEY'],
          'category': category,
          'country': 'us',
        },
      );
      if (response.statusCode == 200) {

       debugPrint('the list from the api : ${NewsInformation.fromJson(response.data).articles}');

       return NewsInformation.fromJson(response.data).articles;
      } else {
        debugPrint("Error: Status Code ${response.statusCode}");
        return Future.error('${response.statusCode}');
      }
    }  catch (e) {
      debugPrint("General Error: $e");
      showToast(message: '$e');
      return Future.error('$e');

    }
  }
}

