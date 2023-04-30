import 'package:dio/dio.dart';

class DioHelper {
  static Dio dio=Dio(
    BaseOptions(
      baseUrl: 'https://student.valuxapps.com/api/',
      receiveDataWhenStatusError: true,
    ),
  );

  static Future<Response?> getData({
    required String url,
     Map<String, dynamic>? query,
    String langg = 'en',
    String? tokenn,
  }) async
  {
    dio.options.headers =
    {
      'lang':langg,
      'Authorization': tokenn??'',
      'Content-Type': 'application/json',
    };
    return dio.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response> PostData({
    required String url,
    //Map<String, dynamic> query,
    required Map<String, dynamic> data,
    String langg = 'en',
    String? tokenn,
  }) async
  {
    dio.options.headers =
    {
      'lang':langg,
      'Authorization': tokenn??'',
      'Content-Type': 'application/json',
    };
    return dio.post(
      url,
      //queryParameters: query,
      data: data,
    );
  }

  static Future<Response> PutData({
    required String url,
    //Map<String, dynamic> query,
    required Map<String, dynamic> data,
    String langg = 'en',
    String? tokenn,
  }) async
  {
    dio.options.headers =
    {
      'lang':langg,
      'Authorization': tokenn??'',
      'Content-Type': 'application/json',
    };
    return dio.put(
      url,
      //queryParameters: query,
      data: data,
    );
  }


}