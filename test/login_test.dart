import 'package:flutter_project_target/stores/login_store/login_store.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LoginStore Tests', () {
    late LoginStore loginStore;

    setUp(() {
      loginStore = LoginStore();
    });

    test('Initial values are empty', () {
      expect(loginStore.username, '');
      expect(loginStore.password, '');
    });

    test('Username and password validation', () {
      loginStore.setUsername('teste1');
      loginStore.setPassword('teste1');
      expect(loginStore.isValid, isTrue);

      loginStore.setUsername('user');
      loginStore.setPassword('1');
      expect(loginStore.isValid, isFalse);
    });

    test('Login with valid credentials returns success', () async {
      loginStore.setUsername('teste1');
      loginStore.setPassword('teste1');
      final result = await loginStore.login();
      expect(result, LoginResult.success);
    });

    test('Login with invalid credentials returns error', () async {
      loginStore.setUsername('invalid');
      loginStore.setPassword('invalid');
      final result = await loginStore.login();
      expect(result, LoginResult.invalidUser);
    });
  });
}
