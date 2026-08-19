import 'package:flutter_test/flutter_test.dart';
import 'package:transitops_gis/core/error/exceptions.dart';
import 'package:transitops_gis/core/error/failures.dart';
import 'package:transitops_gis/core/error/result.dart';

void main() {
  group('Result', () {
    test('fold returns success data', () {
      const result = Success<int>(4);
      expect(
        result.fold(onSuccess: (data) => data * 2, onFailure: (_) => -1),
        8,
      );
    });

    test('fold returns failure', () {
      const result = FailureResult<int>(NetworkFailure('offline'));
      expect(
        result.fold(onSuccess: (_) => 'ok', onFailure: (f) => f.message),
        'offline',
      );
    });
  });

  group('mapExceptionToFailure', () {
    test('maps network exceptions', () {
      expect(mapExceptionToFailure(const NetworkException()), isA<NetworkFailure>());
    });

    test('maps unexpected values to UnexpectedFailure', () {
      expect(mapExceptionToFailure(StateError('x')), isA<UnexpectedFailure>());
    });
  });
}
