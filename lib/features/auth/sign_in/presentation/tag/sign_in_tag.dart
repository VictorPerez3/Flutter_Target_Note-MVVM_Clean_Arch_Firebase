import '../../../../../core/base/firebase/analytics/fb_analytics_base.dart';
import '../../../../../core/base/firebase/analytics/fb_analytics_events_enum.dart';
import '../../../../../core/base/firebase/crashlytics/fb_crashlytics_provider.dart';
import '../../../../../core/base/injection/inject.dart';

class SignInTag extends AnalyticsBase {
  const SignInTag(super.analytics);

  @override
  String get category => 'sign_in';

  Future<void> onLoginEvent(String label) async {
    sendEvent(event: AnalyticsEventsEnum.login, label: label);
  }

  Future<void> onLoginSucceed(String userId) async {
    await provider.setUserId(userId);
    Inject.find<FbCrashlyticsProvider>().setUserIdentifier(userId);
  }
}
