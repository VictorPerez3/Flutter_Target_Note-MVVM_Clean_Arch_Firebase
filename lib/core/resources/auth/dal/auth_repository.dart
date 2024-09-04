import 'package:flutter_project_target/core/resources/auth/dal/dto/auth_user_body.dart';

import '../../../base/dal/storage/storage_interface.dart';
import '../domain/constants/auth_storage_constants.dart';
import '../domain/entities/user_entity.dart';
import 'datasource/auth_datasource_interface.dart';
import 'mappers/user_mapper.dart';

class AuthRepository {
  final IAuthDataSource authDataSource;
  final IStorage storage;

  const AuthRepository({required this.authDataSource, required this.storage});

  Future<({String token, User user})> authenticate({
    required String username,
    required String password,
  }) async {
    final body = AuthUserBody(username: username, password: password);
    final response = await authDataSource.authenticateUser(body);
    final model = UserMapper.toModel(response.data!.user);
    return (user: model, token: response.data!.token);
  }

  Future<void> save(User user) async {
    final json = UserMapper.toJson(user);
    await storage.write(key: AuthStorageConstants.user, value: json);
  }

  Future<void> saveToken(String token) async {
    await storage.write(
      key: AuthStorageConstants.tokenAuthorization,
      value: token,
    );
  }

  Future<bool> isLoggedIn() async {
    final user = await storage.read(AuthStorageConstants.user);
    final token = await storage.read(AuthStorageConstants.tokenAuthorization);

    return token != null && user != null;
  }

  Future<void> clearData() async {
    await storage.remove(AuthStorageConstants.user);
    await storage.remove(AuthStorageConstants.tokenAuthorization);
  }

  Future<({String token, User user})> signUp(
      {required String username, required String password}) async {
    final body = AuthUserBody(username: username, password: password);
    final response = await authDataSource.signUp(body);
    final model = UserMapper.toModel(response.data!.user);
    return (user: model, token: response.data!.token);
  }
}
