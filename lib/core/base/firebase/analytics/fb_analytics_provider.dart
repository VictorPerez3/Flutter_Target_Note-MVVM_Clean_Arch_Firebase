abstract class FbAnalyticsProvider {
  const FbAnalyticsProvider();

  Future<void> setUserId(String? id);

  Future<void> setCurrentScreen(String screenName);

  Future<void> sendEvent({
    required String name,
    required Map<String, Object> parameters,
    // required Map<String, dynamic> parameters,
  });
}
