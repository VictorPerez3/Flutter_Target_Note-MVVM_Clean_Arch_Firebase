import '../../../../../core/base/firebase/analytics/fb_analytics_base.dart';
import '../../../../../core/base/firebase/analytics/fb_analytics_events_enum.dart';

class NoteListTag extends AnalyticsBase {
  const NoteListTag(super.analytics);

  @override
  String get category => 'note_list';

  Future<void> onLogoutEvent(String label) async {
    sendEvent(event: AnalyticsEventsEnum.logout, label: label);
  }

  Future<void> onListToDetailEvent(String label) async {
    sendEvent(event: AnalyticsEventsEnum.listToDetail, label: label);
  }

  Future<void> onDeleteNoteEvent(String label) async {
    sendEvent(event: AnalyticsEventsEnum.deleteNote, label: label);
  }
}
