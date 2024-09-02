import '../../../../../base/dal/data/error.data.dart';
import '../../../../../base/mixins/l18n.mixin.dart';
import '../../../domain/constants/auth_errors.constants.dart';
import '../../../domain/exceptions/username_or_password_incorrect.exception.dart';
import '../../data/user.data.dart';
import '../../dto/auth_user.body.dart';
import '../../dto/auth_user.response.dart';

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

    if (!validUsers.containsKey(body.username)) {
      throw UsernameOrPasswordIncorrectException(
        failure: ErrorData(
            id: AuthErrorsConstants.usernameId,
            message: l18n.strings.authError.usernameMessage),
      );
    } else if (validUsers[body.username] != body.password) {
      throw UsernameOrPasswordIncorrectException(
        failure: ErrorData(
            id: AuthErrorsConstants.passwordId,
            message: l18n.strings.authError.passwordMessage),
      );
    }

    return AuthUserResponse(
      data: AuthUserDataResponse(
        user: UserData(id: userIds[body.username]!, username: body.username),
        token: 'fake_token',
      ),
      errors: null,
    );
  }
}
