import '../../dto/auth_user_body.dart';
import '../../dto/auth_user_response.dart';

abstract class IFbAuthDataSource {
  Future<AuthUserResponse> authenticateUser(AuthUserBody body);

  Future<AuthUserResponse> signUp(AuthUserBody body);
}
