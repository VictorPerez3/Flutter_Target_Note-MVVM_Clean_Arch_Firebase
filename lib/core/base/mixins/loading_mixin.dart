import '../../../features/shared/loading/loading_viewmodel.dart';
import '../injection/inject.dart';

mixin LoadingMixin {
  LoadingViewModel get loading => Inject.find<LoadingViewModel>();
}

