import 'package:mobx/mobx.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStore with _$LoginStore;

enum LoginResult {
  success,
  invalidUser,
  invalidPassword,
}

abstract class _LoginStore with Store {

  @observable
  String username = '';

  @observable
  String password = '';

  @action
  void setUsername(String value) {
    username = value.trimRight();
  }

  @action
  void setPassword(String value) {
    password = value.trimRight();
  }

  @computed
  bool get isValid {
    return _isPasswordValid && _isUsernameValid;
  }

  bool get _isPasswordValid {
    return password.length >= 2 &&
        password.length <= 20 &&
        RegExp(r'^[a-zA-Z0-9]+$').hasMatch(password);
  }

  bool get _isUsernameValid {
    return username.length <= 20 && username.isNotEmpty;
  }

// Função Mock para simular login
  Future<LoginResult> login() async {
    await Future.delayed(const Duration(seconds: 1));

    Map<String, String> validUsers = {
      "teste1": "teste1",
      "teste2": "teste2",
    };

    if (!validUsers.containsKey(username)) {
      return LoginResult.invalidUser;
    }

    if (validUsers[username] != password) {
      return LoginResult.invalidPassword;
    }

    return LoginResult.success;
  }
}
