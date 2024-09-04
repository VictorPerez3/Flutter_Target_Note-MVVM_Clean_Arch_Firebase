import '../../dal/auth_repository.dart';
import '../../dal/datasource/firebase_authentication/fb_authentication_datasource_interface.dart';
import '../../dal/dto/auth_user_body.dart';
import '../../dal/mappers/user_mapper.dart';

class AuthUsecase {
  final AuthRepository authRepository;
  final IFbAuthDataSource authDataSource;

  const AuthUsecase(
      {required this.authRepository, required this.authDataSource});

  Future<String?> signIn({
    required String username,
    required String password,
  }) async {
    final body = AuthUserBody(username: username, password: password);
    final response = await authDataSource.authenticateUser(body);
    final user = UserMapper.toModel(response.data!.user);
    final token = response.data!.token;

    await authRepository.saveUser(user);
    await authRepository.saveToken(token);

    return user.id;
  }

  Future<String?> signUp({
    required String username,
    required String password,
  }) async {
    final body = AuthUserBody(username: username, password: password);
    final response = await authDataSource.signUp(body);
    final user = UserMapper.toModel(response.data!.user);
    final token = response.data!.token;

    await authRepository.saveUser(user);
    await authRepository.saveToken(token);

    return user.id;
  }
}
