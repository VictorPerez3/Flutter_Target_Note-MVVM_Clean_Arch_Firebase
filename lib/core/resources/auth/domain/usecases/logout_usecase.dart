import '../../../auth/dal/auth_repository.dart';

class LogoutUsecase {
  final AuthRepository authRepository;

  const LogoutUsecase({required this.authRepository});

  Future<void> logout() {
    return authRepository.clearUserData();
  }
}
