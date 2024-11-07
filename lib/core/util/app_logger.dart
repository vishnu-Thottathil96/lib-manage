import 'dart:developer';

class AppLogger {
  /// Logs a general event with optional page and additional information.
  static void logEvent({
    required String event,
    String? page,
    String? additionalInfo,
  }) {
    final pageInfo = page != null ? '| Page: $page' : '';
    final extraInfo = additionalInfo != null ? '| Info: $additionalInfo' : '';

    log('EVENT: $event$pageInfo$extraInfo');
  }

  /// Logs a lifecycle event with the specified page and an optional reason.
  static void logLifecycleEvent({
    required String event,
    required String page,
    String? reason,
  }) {
    final reasonInfo = reason != null ? '| Reason: $reason' : '';

    log('LifecycleEvent: $event | Page: $page$reasonInfo');
  }

  /// Logs an error message with an optional page context.
  static void logError({
    required String message,
    String? page,
  }) {
    final pageInfo = page != null ? '| Page: $page' : '';

    log('ERROR: $message$pageInfo',
        level: 1000); // 1000 is the level for error in Dart
  }

  /// Logs a state change with optional page context and additional information.
  static void logStateChange({
    required String state,
    String? page,
    String? additionalInfo,
  }) {
    final pageInfo = page != null ? '| Page: $page' : '';
    final extraInfo = additionalInfo != null ? '| Info: $additionalInfo' : '';

    log('STATE CHANGE: $state$pageInfo$extraInfo');
  }
}
