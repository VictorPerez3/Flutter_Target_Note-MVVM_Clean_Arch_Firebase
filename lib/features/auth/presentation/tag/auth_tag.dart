import '../../../../core/base/firebase/analytics/fb_analytics_base.dart';
import '../../../../core/base/firebase/crashlytics/fb_crashlytics_provider.dart';
import '../../../../core/base/injection/inject.dart';

class AuthTag extends AnalyticsBase {
  const AuthTag(super.analytics);

  @override
  String get category => 'auth';

  Future<void> onLoginEvent(String label) async {
    sendLoginEvent(label);
  }

  Future<void> onCreateUserEvent(String label) async {
    sendCreateUserEvent(label);
  }

  Future<void> onLoginSucceed(String userId) async {
    await provider.setUserId(userId);
    Inject.find<FbCrashlyticsProvider>().setUserIdentifier(userId);
  }
}
