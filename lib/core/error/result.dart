import 'package:equatable/equatable.dart';
import 'package:transitops_gis/core/error/failures.dart';

sealed class Result<T> extends Equatable {
  const Result();

  bool get isSuccess => this is Success<T>;
  bool get isFailure => this is FailureResult<T>;

  R fold<R>({
    required R Function(T data) onSuccess,
    required R Function(Failure failure) onFailure,
  }) {
    final self = this;
    return switch (self) {
      Success<T>() => onSuccess(self.data),
      FailureResult<T>() => onFailure(self.failure),
    };
  }

  @override
  List<Object?> get props => [];
}

class Success<T> extends Result<T> {
  const Success(this.data);

  final T data;

  @override
  List<Object?> get props => [data];
}

class FailureResult<T> extends Result<T> {
  const FailureResult(this.failure);

  final Failure failure;

  @override
  List<Object?> get props => [failure];
}
