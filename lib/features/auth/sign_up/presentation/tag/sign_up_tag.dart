import '../../../../../core/base/firebase/analytics/fb_analytics_base.dart';
import '../../../../../core/base/firebase/analytics/fb_analytics_events_enum.dart';

class SignUpTag extends AnalyticsBase {
  const SignUpTag(super.analytics);

  @override
  String get category => 'sign_up';

  Future<void> onCreateUserEvent(String label) async {
    sendEvent(event: AnalyticsEventsEnum.createUser, label: label);
  }
}
