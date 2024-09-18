import '../../../../../core/base/firebase/analytics/fb_analytics_base.dart';
import '../../../../../core/base/firebase/analytics/fb_analytics_events_enum.dart';

class NoteDetailsTag extends AnalyticsBase {
  const NoteDetailsTag(super.analytics);

  @override
  String get category => 'note_details';

  Future<void> onDetailToListEvent(String label) async {
    sendEvent(event: AnalyticsEventsEnum.detailToList, label: label);
  }

  Future<void> onSaveNoteEvent(String label) async {
    sendEvent(event: AnalyticsEventsEnum.saveNote, label: label);
  }

  Future<void> onEditNoteEvent(String label) async {
    sendEvent(event: AnalyticsEventsEnum.editNote, label: label);
  }
}
