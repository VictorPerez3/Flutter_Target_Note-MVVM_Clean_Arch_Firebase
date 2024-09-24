import '../../../base/dal/data/error_data.dart';
import '../../../base/dal/storage/storage_interface.dart';
import '../../../base/mixins/l18n_mixin.dart';
import '../../note/domain/constants/note_errors_constants.dart';
import '../../note/domain/exceptions/userid_not_found_exception.dart';
import '../domain/constants/auth_storage_constants.dart';
import '../domain/entities/user_entity.dart';
import 'datasource/firebase_authentication/fb_authentication_datasource_interface.dart';
import 'mappers/user_mapper.dart';

class AuthRepository with l18nMixin {
  final IFbAuthDataSource authDataSource;
  final IStorage storage;

  const AuthRepository({required this.authDataSource, required this.storage});

  Future<void> saveUser(User user) async {
    final json = UserMapper.toJson(user);
    await storage.write(key: AuthStorageConstants.user, value: json);
  }

  Future<void> saveToken(String token) async {
    await storage.write(
      key: AuthStorageConstants.tokenAuthorization,
      value: token,
    );
  }

  Future<bool> isLoggedIn() async {
    final user = await storage.read(AuthStorageConstants.user);
    final token = await storage.read(AuthStorageConstants.tokenAuthorization);

    return token != null && user != null;
  }

  Future<String> getUserId() async {
    final user =
        await storage.read<Map<String, dynamic>>(AuthStorageConstants.user);
    if (user != null && user.containsKey('id')) {
      return user['id'] as String;
    } else {
      throw UseridNotFoundException(
          failure: ErrorData(
              message: l18n.strings.noteError.useridNotFoundMessage,
              id: NoteErrorsConstants.useridNotFoundId));
    }
  }

  Future<void> clearUserData() async {
    await storage.remove(AuthStorageConstants.user);
    await storage.remove(AuthStorageConstants.tokenAuthorization);
  }
}
