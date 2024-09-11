import '../../dal/auth_repository.dart';
import '../../dal/datasource/firebase_authentication/fb_authentication_datasource_interface.dart';
import '../../dal/dto/auth_user_body.dart';
import '../../dal/mappers/user_mapper.dart';

class SignUpUsecase {
  final AuthRepository authRepository;
  final IFbAuthDataSource authDataSource;

  const SignUpUsecase(
      {required this.authRepository, required this.authDataSource});

  Future<String?> signUp({
    required String email,
    required String password,
  }) async {
    final body = AuthUserBody(email: email, password: password);
    final response = await authDataSource.signUp(body);
    final user = UserMapper.toModel(response.data!.user);
    final token = response.data!.token;

    await authRepository.saveUser(user);
    await authRepository.saveToken(token);

    return user.id;
  }
}
