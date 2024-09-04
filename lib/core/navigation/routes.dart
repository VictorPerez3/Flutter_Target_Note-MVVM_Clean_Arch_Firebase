import '../base/injection/inject.dart';
import '../resources/auth/dal/auth_repository.dart';

class Routes {
  static Future<String> get initialRoute async {
    try {
      final authRepository = AuthRepository(
        authDataSource: Inject.find(),
        storage: Inject.find(),
      );
      final isUserLoggedIn = await authRepository.isLoggedIn();
      if (isUserLoggedIn) {
        return note;
      }
      return auth;
    } catch (err) {
      return auth;
    }
  }

  static const auth = '/auth';
  static const note = '/note';
}
