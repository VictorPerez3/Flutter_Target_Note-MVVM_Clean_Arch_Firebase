import '../../mixins/send_event.mixin.dart';
import 'analytics_provider.dart';

abstract class AnalyticsBase with SendEventMixin {
  final FbAnalyticsProvider analyticsProvider;

  const AnalyticsBase(this.analyticsProvider);

  @override
  FbAnalyticsProvider get provider => analyticsProvider;
}
