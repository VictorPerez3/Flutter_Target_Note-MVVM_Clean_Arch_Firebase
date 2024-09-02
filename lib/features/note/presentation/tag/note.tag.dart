import '../../../../core/base/firebase/analytics/analytics_base.dart';

class NoteTag extends AnalyticsBase {
  const NoteTag(super.analytics);

  @override
  String get category => 'note';

  Future<void> onLogoutEvent(String label) async {
    sendLogoutEvent(label);
  }

  Future<void> onSaveNoteEvent(String label) async {
    sendSaveNoteEvent(label);
  }

  Future<void> onEditNoteEvent(String label) async {
    sendEditNoteEvent(label);
  }

  Future<void> onDeleteNoteEvent(String label) async {
    sendDeleteNoteEvent(label);
  }
}
