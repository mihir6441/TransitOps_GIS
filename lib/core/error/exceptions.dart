class AppException implements Exception {
  const AppException(this.message, {this.cause});

  final String message;
  final Object? cause;

  @override
  String toString() => message;
}

class NetworkException extends AppException {
  const NetworkException({
    String message = 'Network unavailable',
    Object? cause,
  }) : super(message, cause: cause);
}

class RequestTimeoutException extends AppException {
  const RequestTimeoutException({
    String message = 'Request timed out',
    Object? cause,
  }) : super(message, cause: cause);
}

class ServerException extends AppException {
  const ServerException({
    String message = 'Server error',
    Object? cause,
    this.statusCode,
  }) : super(message, cause: cause);

  final int? statusCode;
}

class CacheException extends AppException {
  const CacheException({String message = 'Cache error', Object? cause})
    : super(message, cause: cause);
}

class PermissionException extends AppException {
  const PermissionException({
    String message = 'Permission denied',
    Object? cause,
  }) : super(message, cause: cause);
}

class LocationException extends AppException {
  const LocationException({String message = 'Location error', Object? cause})
    : super(message, cause: cause);
}

class GisException extends AppException {
  const GisException({String message = 'GIS service error', Object? cause})
    : super(message, cause: cause);
}

class UnexpectedException extends AppException {
  const UnexpectedException({
    String message = 'Unexpected error',
    Object? cause,
  }) : super(message, cause: cause);
}
