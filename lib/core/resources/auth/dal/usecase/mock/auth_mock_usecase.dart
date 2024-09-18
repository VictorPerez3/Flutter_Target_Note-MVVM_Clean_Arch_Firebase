import '../../../../../base/dal/data/error_data.dart';
import '../../../../../base/mixins/l18n_mixin.dart';
import '../../../domain/constants/auth_errors_constants.dart';
import '../../../domain/exceptions/username_or_password_incorrect_exception.dart';
import '../../data/user_data.dart';
import '../../dto/auth_user_body.dart';
import '../../dto/auth_user_response.dart';

// MOCK USERS
const strMockUsername1 = 'teste1';
const strMockPassword1 = 'teste1';
const strMockUserId1 = '123';

const strMockUsername2 = 'teste2';
const strMockPassword2 = 'teste2';
const strMockUserId2 = '456';

class AuthMockUseCase with l18nMixin {
  Future<AuthUserResponse> authenticateUser(AuthUserBody body) async {
    await Future.delayed(const Duration(milliseconds: 500));

    Map<String, String> validUsers = {
      strMockUsername1: strMockPassword1,
      strMockUsername2: strMockPassword2,
    };

    Map<String, String> userIds = {
      strMockUsername1: strMockUserId1,
      strMockUsername2: strMockUserId2,
    };

    if (!validUsers.containsKey(body.email) ||
        validUsers[body.email] != body.password) {
      throw UsernameOrPasswordIncorrectException(
        failure: ErrorData(
            id: AuthErrorsConstants.credentialsId,
            message: l18n.strings.authError.credentialsMessage),
      );
    }

    return AuthUserResponse(
      data: AuthUserDataResponse(
        user: UserData(id: userIds[body.email]!, username: body.email),
        token: 'fake_token',
      ),
      errors: null,
    );
  }
}
