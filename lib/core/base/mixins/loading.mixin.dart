import '../../../features/shared/loading/loading.viewmodel.dart';
import '../injection/inject.dart';

mixin LoadingMixin {
  LoadingViewModel get loading => Inject.find<LoadingViewModel>();
}

