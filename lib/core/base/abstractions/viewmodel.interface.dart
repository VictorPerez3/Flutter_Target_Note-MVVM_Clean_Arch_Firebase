import '../mixins/loading.mixin.dart';

abstract class IViewModel with LoadingMixin {
  void dispose();
}
