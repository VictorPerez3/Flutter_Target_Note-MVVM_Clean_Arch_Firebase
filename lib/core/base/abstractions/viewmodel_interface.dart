import '../mixins/loading_mixin.dart';

abstract class IViewModel with LoadingMixin {
  void dispose();
}
