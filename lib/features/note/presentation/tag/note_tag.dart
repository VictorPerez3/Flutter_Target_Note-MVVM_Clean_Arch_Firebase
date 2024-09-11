import '../../../../core/base/firebase/analytics/fb_analytics_base.dart';
import '../../../../core/base/firebase/analytics/fb_analytics_events_enum.dart';

class NoteTag extends AnalyticsBase {
  const NoteTag(super.analytics);

  @override
  String get category => 'note';

  Future<void> onLogoutEvent(String label) async {
    sendEvent(event: AnalyticsEventsEnum.logout, label: label);
  }

  Future<void> onSaveNoteEvent(String label) async {
    sendEvent(event: AnalyticsEventsEnum.saveNote, label: label);
  }

  Future<void> onEditNoteEvent(String label) async {
    sendEvent(event: AnalyticsEventsEnum.editNote, label: label);
  }

  Future<void> onDeleteNoteEvent(String label) async {
    sendEvent(event: AnalyticsEventsEnum.deleteNote, label: label);
  }
}
