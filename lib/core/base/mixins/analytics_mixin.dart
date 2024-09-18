import '../firebase/analytics/fb_analytics_base.dart';
import '../injection/inject.dart';

mixin AnalyticsMixin<T extends AnalyticsBase> {
  T get tag => Inject.find<T>();
}