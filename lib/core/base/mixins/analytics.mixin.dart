import '../firebase/analytics/analytics_base.dart';
import '../injection/inject.dart';

mixin AnalyticsMixin<T extends AnalyticsBase> {
  T get tag => Inject.find<T>();
}