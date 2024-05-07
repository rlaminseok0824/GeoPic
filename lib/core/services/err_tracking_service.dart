import 'dart:async';

import 'package:flutter/foundation.dart';

/// this service can be used by another service or repository
/// this service MUST NOT USE another service or repository
abstract class ErrTrackingService {
  static Future<void> init(Future Function() appRunner) async {
    runZonedGuarded(() async {
      await appRunner();
      if (kDebugMode) return;
    }, (error, stack) {
      captureException(error, stackTrace: stack);
    });
  }

  static Future captureException(
    dynamic throwable, {
    StackTrace? stackTrace,
    String? reason,
  }) async {
    print(throwable);
    print(stackTrace);
  }
}
