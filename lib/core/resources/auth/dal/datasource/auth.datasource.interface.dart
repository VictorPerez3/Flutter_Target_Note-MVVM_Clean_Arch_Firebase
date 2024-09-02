import '../dto/auth_user.body.dart';
import '../dto/auth_user.response.dart';

abstract class IAuthDataSource {
  Future<AuthUserResponse> authenticateUser(AuthUserBody body);

  Future<AuthUserResponse> signUp(AuthUserBody body);
}
