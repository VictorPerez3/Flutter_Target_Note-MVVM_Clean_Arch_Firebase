import 'package:firebase_auth/firebase_auth.dart';

import '../../../../base/dal/data/error_data.dart';
import '../../../../base/mixins/l18n_mixin.dart';
import '../../domain/constants/auth_errors_constants.dart';
import '../../domain/exceptions/email_already_in_use_exception.dart';
import '../../domain/exceptions/invalid_email_exception.dart';
import '../../domain/exceptions/network_request_failed_exception.dart';
import '../../domain/exceptions/other_auth_exception.dart';
import '../../domain/exceptions/username_or_password_incorrect_exception.dart';
import '../data/user_data.dart';
import '../dto/auth_user_body.dart';
import '../dto/auth_user_response.dart';
import 'auth_datasource_interface.dart';

class AuthDataSource with l18nMixin implements IAuthDataSource {
  @override
  Future<AuthUserResponse> authenticateUser(AuthUserBody body) async {
    try {
      final response = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: body.username,
        password: body.password,
      );

      final userUid = response.user!.uid;
      final userEmail = response.user?.email ?? '';
      final userToken = await response.user?.getIdToken() ?? '';

      return AuthUserResponse(
        data: AuthUserDataResponse(
          user: UserData(id: userUid, username: userEmail),
          token: userToken,
        ),
        errors: null,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' ||
          e.code == 'invalid-credential' ||
          e.code == 'wrong-password') {
        throw UsernameOrPasswordIncorrectException(
          failure: ErrorData(
              id: AuthErrorsConstants.credentialsId,
              message: l18n.strings.authError.credentialsMessage),
        );
      } else if (e.code == 'network-request-failed') {
        throw NetworkRequestFailedException(ErrorData(
            id: AuthErrorsConstants.networkRequestFailedId,
            message: l18n.strings.authError.networkRequestFailedMessage));
      } else {
        throw OtherAuthException(ErrorData(
            id: AuthErrorsConstants.otherErrorId,
            message: e.message ?? l18n.strings.authError.otherErrorMessage));
      }
    } catch (e) {
      throw OtherAuthException(ErrorData(
          id: AuthErrorsConstants.otherErrorId, message: e.toString()));
    }
  }

  @override
  Future<AuthUserResponse> signUp(AuthUserBody body) async {
    try {
      final response =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: body.username,
        password: body.password,
      );

      final userUid = response.user!.uid;
      final userEmail = response.user?.email ?? '';
      final userToken = await response.user?.getIdToken() ?? '';

      return AuthUserResponse(
        data: AuthUserDataResponse(
          user: UserData(id: userUid, username: userEmail),
          token: userToken,
        ),
        errors: null,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        throw EmailAlreadyInUseException(ErrorData(
            id: AuthErrorsConstants.otherErrorId,
            message: l18n.strings.authError.invalidEmailMessage));
      } else if (e.code == 'invalid-email') {
        throw InvalidEmailException(ErrorData(
            id: AuthErrorsConstants.invalidEmailId,
            message: l18n.strings.authError.invalidEmailMessage));
      } else if (e.code == 'network-request-failed') {
        throw NetworkRequestFailedException(ErrorData(
            id: AuthErrorsConstants.networkRequestFailedId,
            message: l18n.strings.authError.networkRequestFailedMessage));
      }
    } catch (e) {
      throw OtherAuthException(ErrorData(
          id: AuthErrorsConstants.otherErrorId, message: e.toString()));
    }
    throw OtherAuthException(ErrorData(
        id: AuthErrorsConstants.otherErrorId,
        message: l18n.strings.authError.otherErrorMessage));
  }
}
