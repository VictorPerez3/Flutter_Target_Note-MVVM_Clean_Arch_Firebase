import 'dart:developer';

import 'fb_analytics_provider.dart';

class AnalyticsMock implements FbAnalyticsProvider {
  @override
  Future<void> sendEvent({
    required String name,
    required Map<String, dynamic> parameters,
  }) async {
    log(
      'Event: ${parameters.values}'
          .replaceAll('(', '')
          .replaceAll(')', '')
          .replaceAll(', ', ':'),
      name: 'Analytics',
    );
  }

  @override
  Future<void> setCurrentScreen(String screenName) async {
    log('setCurrentScreen: $screenName', name: 'Analytics');
  }

  @override
  Future<void> setUserId(String? id) async {
    log('setUserId: $id', name: 'Analytics');
  }
}
