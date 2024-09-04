import '../dto/auth_user_body.dart';
import '../dto/auth_user_response.dart';

abstract class IAuthDataSource {
  Future<AuthUserResponse> authenticateUser(AuthUserBody body);

  Future<AuthUserResponse> signUp(AuthUserBody body);
}
