import '../extensions/string_extension.dart';
import '../firebase/analytics/fb_analytics_events_enum.dart';
import '../firebase/analytics/fb_analytics_provider.dart';

mixin SendEventMixin {
  FbAnalyticsProvider get provider;

  String get category;

  Future<void> sendEvent({
    required AnalyticsEventsEnum event,
    required String label,
    Map<String, dynamic>? customParams,
  }) {
    return provider.sendEvent(
      name: event.value,
      parameters: {
        'category': category,
        'label': label.toAnalyticsFormat,
        ...?customParams,
      },
    );
  }

  Future<void> setUserId(String? useId) {
    return provider.setUserId(useId);
  }
}
