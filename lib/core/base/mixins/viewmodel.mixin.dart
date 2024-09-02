import '../injection/inject.dart';

mixin ViewModelMixin<T extends Object> {
  T get viewModel => Inject.find<T>();
}
