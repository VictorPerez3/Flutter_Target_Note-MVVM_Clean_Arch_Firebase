import '../crashlytics_provider.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

class FbCrashlyticsImpl implements FbCrashlyticsProvider {
  final FirebaseCrashlytics _crashlytics = FirebaseCrashlytics.instance;

  @override
  Future<void> logMessage(String message) async {
    await _crashlytics.log(message);
  }

  @override
  Future<void> recordError(
    exception,
    StackTrace? stack, {
    reason,
    bool? printDetails,
    bool fatal = false,
  }) async {
    await _crashlytics.recordError(exception, stack,
        reason: reason, printDetails: printDetails, fatal: fatal);
  }

  @override
  Future<void> setCrashlyticsCollectionEnabled(bool enabled) async {
    await _crashlytics.setCrashlyticsCollectionEnabled(enabled);
  }

  @override
  Future<void> setCustomKey(String key, Object value) async {
    await _crashlytics.setCustomKey(key, value);
  }

  @override
  Future<void> setUserIdentifier(String identifier) async {
    await _crashlytics.setUserIdentifier(identifier);
  }

  @override
  Future<void> recordFlutterFatalError(
    flutterErrorDetails,
    {bool fatal = false}
  ) async {
    await _crashlytics.recordFlutterFatalError(flutterErrorDetails);
  }
}
