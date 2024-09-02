import 'package:firebase_analytics/firebase_analytics.dart';

import '../analytics_provider.dart';

class FbAnalyticsImpl implements FbAnalyticsProvider {
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  @override
  Future<void> sendEvent({
    required String name,
    required Map<String, Object> parameters,
  }) async {
    await _analytics.logEvent(name: name, parameters: parameters);
  }

  @override
  Future<void> setCurrentScreen(String screenName) async {
    await _analytics.logScreenView(screenName: screenName);
  }

  @override
  Future<void> setUserId(String? id) async {
    await _analytics.setUserId(id: id);
  }
}
