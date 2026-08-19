import 'package:dio/dio.dart';
import 'package:transitops_gis/core/config/app_config.dart';
import 'package:transitops_gis/core/constants/app_constants.dart';
import 'package:transitops_gis/core/error/exceptions.dart';

class DioClient {
  DioClient._();

  static Dio create(AppConfig config) {
    final dio = Dio(
      BaseOptions(
        baseUrl: config.apiBaseUrl,
        connectTimeout: AppConstants.networkTimeout,
        receiveTimeout: AppConstants.networkTimeout,
        sendTimeout: AppConstants.networkTimeout,
        headers: const {'Accept': 'application/json'},
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onError: (error, handler) {
          handler.reject(
            DioException(
              requestOptions: error.requestOptions,
              response: error.response,
              type: error.type,
              error: _mapDioError(error),
            ),
          );
        },
      ),
    );

    return dio;
  }

  static AppException _mapDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.transformTimeout:
        return RequestTimeoutException(cause: error);
      case DioExceptionType.connectionError:
        return NetworkException(cause: error);
      case DioExceptionType.badResponse:
        return ServerException(
          message: 'Request failed',
          cause: error,
          statusCode: error.response?.statusCode,
        );
      case DioExceptionType.cancel:
      case DioExceptionType.badCertificate:
      case DioExceptionType.unknown:
        return UnexpectedException(cause: error);
    }
  }
}
