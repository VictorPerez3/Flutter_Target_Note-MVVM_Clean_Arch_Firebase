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
      return signIn;
    } catch (err) {
      return signIn;
    }
  }

  static const signIn = '/auth/sign_in';
  static const signUp = '/auth/sign_up';
  static const note = '/note';
}
