import 'package:mobx/mobx.dart';

part 'form_store.g.dart';

class FormStore = _FormStore with _$FormStore;

enum LoginResult {
  success,
  invalidUser,
  invalidPassword,
}

abstract class _FormStore with Store {
  //////////////////////////////////////////
  /*@observable
  String username = '';

  @observable
  String password = '';*/
  /////////////////////////////////////////

  @observable
  String username = 'teste2';

  @observable
  String password = 'teste2';

  _FormStore() {
    autorun((_) {
      print('AUTORUN: O formulário é válido? $isValid.');
    });
    reaction((_) => isValid, (_) {
      print('REACTION: O formulário é válido? $isValid.');
    });
    when((_) => isValid, () {
      print('WHEN: O formulário é válido? $isValid.');
    });
  }

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
