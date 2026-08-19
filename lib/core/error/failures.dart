import 'package:equatable/equatable.dart';
import 'package:transitops_gis/core/constants/app_strings.dart';
import 'package:transitops_gis/core/error/exceptions.dart';

sealed class Failure extends Equatable {
  const Failure(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

class NetworkFailure extends Failure {
  const NetworkFailure([super.message = AppStrings.networkError]);
}

class TimeoutFailure extends Failure {
  const TimeoutFailure([super.message = AppStrings.timeoutError]);
}

class ServerFailure extends Failure {
  const ServerFailure([super.message = AppStrings.unexpectedError]);
}

class CacheFailure extends Failure {
  const CacheFailure([super.message = AppStrings.unexpectedError]);
}

class PermissionFailure extends Failure {
  const PermissionFailure([super.message = AppStrings.unexpectedError]);
}

class LocationFailure extends Failure {
  const LocationFailure([super.message = AppStrings.unexpectedError]);
}

class GisFailure extends Failure {
  const GisFailure([super.message = AppStrings.unexpectedError]);
}

class UnexpectedFailure extends Failure {
  const UnexpectedFailure([super.message = AppStrings.unexpectedError]);
}

Failure mapExceptionToFailure(Object error) {
  if (error is NetworkException) {
    return NetworkFailure(error.message);
  }
  if (error is RequestTimeoutException) {
    return TimeoutFailure(error.message);
  }
  if (error is ServerException) {
    return ServerFailure(error.message);
  }
  if (error is CacheException) {
    return CacheFailure(error.message);
  }
  if (error is PermissionException) {
    return PermissionFailure(error.message);
  }
  if (error is LocationException) {
    return LocationFailure(error.message);
  }
  if (error is GisException) {
    return GisFailure(error.message);
  }
  if (error is AppException) {
    return UnexpectedFailure(error.message);
  }
  return const UnexpectedFailure();
}
