import 'package:rxdart/rxdart.dart';

class LoadingViewModel {
  final _isLoading = BehaviorSubject<bool>.seeded(false);

  Stream<bool> get isLoadingStream => _isLoading.stream;

  set isLoading(bool val) => _isLoading.sink.add(val);

  void dispose() => _isLoading.close();
}
