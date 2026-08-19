import 'package:flutter/foundation.dart';

/// Lightweight logger that never records credentials or tokens.
class AppLogger {
  const AppLogger();

  void info(String message) {
    if (kDebugMode) {
      debugPrint('[TransitOps] $message');
    }
  }

  void error(String message, [Object? error]) {
    if (kDebugMode) {
      debugPrint('[TransitOps][error] $message');
      if (error != null) {
        debugPrint('[TransitOps][error] $error');
      }
    }
  }
}
