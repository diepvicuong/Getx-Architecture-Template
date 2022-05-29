import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import '../../utils/exception.dart';
import '../../config/app_setting.dart';

class ApiClient {
  Future<Map<String, dynamic>?> get(String url,
      {Map<String, dynamic>? params,
      bool? isCacheFirst = false,
      Duration? cachingAge,
      String? token}) async {
    try {
      if (params != null && params.length > 0) {
        url += '?';
        int index = 0;
        params.forEach((key, value) {
          if (index > 0) {
            url += '&';
          }
          index++;
          url += key + '=';
          url += value.toString();
        });
      }

      Map<String, dynamic> response;
      bool requireCheckToken = AppSetting.requireCheckToken;
      bool hasNewToken = false;

      final _dio = Dio();
      final _dioCacheManager =
          DioCacheManager(CacheConfig(baseUrl: AppSetting.baseUrl));
      _dio.interceptors.add(_dioCacheManager.interceptor);

      // TODO: Get token from local storage
      String accessToken = '';

      do {
        final options = buildCacheOptions(cachingAge ?? const Duration(),
            forceRefresh: true);
        options.headers = {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ' + accessToken,
        };
        var responseData = await _dio.get(url, options: options).timeout(
              const Duration(
                seconds: AppSetting.requestTimeout,
              ),
            );

        if (responseData.data is String) {
          response = jsonDecode(responseData.data);
        } else {
          response = responseData.data;
        }

        hasNewToken = false;
        if (requireCheckToken) {
          // Check token expiration only 1 time.
          requireCheckToken = false;
          if (response['status'] == AppSetting.statusExpired) {
            hasNewToken = await getNewToken();
          }
        }
      } while (hasNewToken);

      _dio.close();

      return response;
    } catch (e, s) {
      throw CustomException(
        'internal_server_error',
        exception: e,
        stack: s,
      );
    }
  }

  Future<Map<String, dynamic>> post(String url,
      {Map<String, dynamic>? params}) async {
    // final _httpClient = http.Client();
    final _dio = Dio();
    final _dioCacheManager =
        DioCacheManager(CacheConfig(baseUrl: AppSetting.baseUrl));
    _dio.interceptors.add(_dioCacheManager.interceptor);

    try {
      var responseMap;
      bool requireCheckToken = AppSetting.requireCheckToken;
      bool hasNewToken = false;

      // String token = await MySharedPreferences.instance.getToken();
      String accessToken = '';
      do {
        _dio.options.headers = {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ' + accessToken,
        };
        final response = await _dio
            .post(url, data: jsonEncode(params))
            .timeout(const Duration(seconds: AppSetting.requestTimeout));

        _dio.close();

        if (response.statusCode != 200 && response.statusCode != 201) {
          throw Exception('error post request');
        }

        if (response.data is String) {
          responseMap = jsonDecode(response.data);
        } else {
          responseMap = response.data;
        }
        hasNewToken = false;
        if (requireCheckToken) {
          // Check token expiration only 1 time.
          requireCheckToken = false;
          if (responseMap != null &&
              responseMap['status'] == AppSetting.statusExpired) {
            hasNewToken = await getNewToken();
          }
        }
      } while (hasNewToken);

      return responseMap;
    } on TimeoutException catch (e, s) {
      _dio.close();
      throw CustomException(
        'error_message.internal_server_error',
        exception: e,
        stack: s,
      );
    } on SocketException catch (e, s) {
      _dio.close();
      throw CustomException(
        'error_message.no_internet',
        exception: e,
        stack: s,
      );
    } catch (e, s) {
      _dio.close();
      throw CustomException(
        'error_message.internal_server_error',
        exception: e,
        stack: s,
      );
    }
  }

  Future<Map<String, dynamic>> patch(String url,
      {Map<String, dynamic>? params}) async {
    final _dio = Dio();
    final _dioCacheManager =
        DioCacheManager(CacheConfig(baseUrl: AppSetting.baseUrl));
    _dio.interceptors.add(_dioCacheManager.interceptor);

    try {
      var responseMap;
      bool requireCheckToken = AppSetting.requireCheckToken;
      bool hasNewToken = false;

      // TODO: get token from local storage
      String accessToken = '';

      do {
        _dio.options.headers = {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ' + accessToken,
        };
        final response = await _dio
            .patch(url, data: jsonEncode(params))
            .timeout(const Duration(seconds: AppSetting.requestTimeout));

        _dio.close();

        if (response.statusCode != 200) {
          throw Exception('error patch request');
        }

        if (response.data is String) {
          responseMap = jsonDecode(response.data);
        } else {
          responseMap = response.data;
        }
        hasNewToken = false;
        if (requireCheckToken) {
          // Check token expiration only 1 time.
          requireCheckToken = false;
          if (responseMap != null &&
              responseMap['status'] == AppSetting.statusExpired) {
            hasNewToken = await getNewToken();
          }
        }
      } while (hasNewToken);

      return responseMap;
    } on TimeoutException catch (e, s) {
      _dio.close();
      throw CustomException(
        'internal_server_error',
        exception: e,
        stack: s,
      );
    } on SocketException catch (e, s) {
      _dio.close();
      throw CustomException(
        'no_internet',
        exception: e,
        stack: s,
      );
    } catch (e, s) {
      _dio.close();
      throw CustomException(
        'internal_server_error',
        exception: e,
        stack: s,
      );
    }
  }

  Future<Map<String, dynamic>> delete(String url) async {
    final _dio = Dio();
    final _dioCacheManager =
        DioCacheManager(CacheConfig(baseUrl: AppSetting.baseUrl));
    _dio.interceptors.add(_dioCacheManager.interceptor);

    try {
      var responseMap;
      bool requireCheckToken = AppSetting.requireCheckToken;
      bool hasNewToken = false;

      // TODO: get token from local storage
      String accessToken = '';

      do {
        _dio.options.headers = {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ' + accessToken,
        };
        final response = await _dio
            .delete(url)
            .timeout(const Duration(seconds: AppSetting.requestTimeout));

        _dio.close();

        if (response.statusCode != 200) {
          throw Exception('error delete request');
        }

        if (response.data is String) {
          responseMap = jsonDecode(response.data);
        } else {
          responseMap = response.data;
        }
        hasNewToken = false;
        if (requireCheckToken) {
          // Check token expiration only 1 time.
          requireCheckToken = false;
          if (responseMap != null &&
              responseMap['status'] == AppSetting.statusExpired) {
            hasNewToken = await getNewToken();
          }
        }
      } while (hasNewToken);

      return responseMap;
    } on TimeoutException catch (e, s) {
      _dio.close();
      throw CustomException(
        'internal_server_error',
        exception: e,
        stack: s,
      );
    } on SocketException catch (e, s) {
      _dio.close();
      throw CustomException(
        'no_internet',
        exception: e,
        stack: s,
      );
    } catch (e, s) {
      _dio.close();
      throw CustomException(
        'internal_server_error',
        exception: e,
        stack: s,
      );
    }
  }

  Future<bool> getNewToken() async {
    //TODO: Add feature here

    return false;
  }
}
