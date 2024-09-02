import '../../../core/resources/auth/dal/auth.repository.dart';

class AuthenticateUsecase {
  final AuthRepository authRepository;

  const AuthenticateUsecase({required this.authRepository});

  Future<String?> signIn({
    required String username,
    required String password,
  }) async {
    final response = await authRepository.authenticate(
      username: username,
      password: password,
    );

    await authRepository.save(response.user);
    await authRepository.saveToken(response.token);

    return response.user.id;
  }

  Future<String?> signUp({
    required String username,
    required String password,
  }) async {
    final response = await authRepository.signUp(
      username: username,
      password: password,
    );

    await authRepository.save(response.user);
    await authRepository.saveToken(response.token);

    return response.user.id;
  }
}
