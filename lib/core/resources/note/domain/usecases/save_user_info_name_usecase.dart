import '../../../../base/utils/encrypt_util.dart';
import '../../../auth/dal/auth_repository.dart';
import '../../dal/datasource/firebase_realtime_database/fb_database_provider.dart';

class SaveUserInfoNameUsecase {
  final FbDatabaseProvider firebaseDatabase;
  final AuthRepository authRepository;

  const SaveUserInfoNameUsecase(
      {required this.firebaseDatabase, required this.authRepository});

  Future<String> saveUserInfoName({
    required String userInfoName,
  }) async {
    final userInfoNameEncrypt = EncryptionUtil.encryptData(userInfoName);
    final userId = await authRepository.getUserId();

    await firebaseDatabase.saveUserInfoName(
        userId: userId, userInfoName: userInfoNameEncrypt);

    return userInfoName;
  }
}
