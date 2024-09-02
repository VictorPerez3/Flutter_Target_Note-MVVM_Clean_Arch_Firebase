import '../extensions/string.extension.dart';
import '../firebase/analytics/analytics_events.enum.dart';
import '../firebase/analytics/analytics_provider.dart';

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

  Future<void> sendClickEvent(String label) {
    return sendEvent(event: AnalyticsEventsEnum.click, label: label);
  }

  Future<void> sendLoginEvent(String label) {
    return sendEvent(event: AnalyticsEventsEnum.login, label: label);
  }

  Future<void> sendCreateUserEvent(String label) {
    return sendEvent(event: AnalyticsEventsEnum.createUser, label: label);
  }

  Future<void> sendLogoutEvent(String label) {
    return sendEvent(event: AnalyticsEventsEnum.logout, label: label);
  }

  Future<void> sendSaveNoteEvent(String label) {
    return sendEvent(event: AnalyticsEventsEnum.saveNote, label: label);
  }

  Future<void> sendEditNoteEvent(String label) {
    return sendEvent(event: AnalyticsEventsEnum.editNote, label: label);
  }

  Future<void> sendDeleteNoteEvent(String label) {
    return sendEvent(event: AnalyticsEventsEnum.deleteNote, label: label);
  }

  Future<void> setUserId(String? useId) {
    return provider.setUserId(useId);
  }
}
