import '../../mixins/send_event_mixin.dart';
import 'fb_analytics_provider.dart';

abstract class AnalyticsBase with SendEventMixin {
  final FbAnalyticsProvider analyticsProvider;

  const AnalyticsBase(this.analyticsProvider);

  @override
  FbAnalyticsProvider get provider => analyticsProvider;
}
