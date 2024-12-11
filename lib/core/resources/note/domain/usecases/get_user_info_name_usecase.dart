import '../../../../base/utils/encrypt_util.dart';
import '../../../auth/dal/auth_repository.dart';
import '../../dal/datasource/firebase_realtime_database/fb_database_provider.dart';

class GetUserInfoNameUsecase {
  final FbDatabaseProvider firebaseDatabase;
  final AuthRepository authRepository;

  const GetUserInfoNameUsecase(
      {required this.firebaseDatabase, required this.authRepository});

  Future<String> getUserInfoName() async {
    final userId = await authRepository.getUserId();

    final userInfoNameEncrypt =
        await firebaseDatabase.getUserInfoName(userId: userId);
    final decryptedUserInfoName =
        EncryptionUtil.decryptData(userInfoNameEncrypt);
    return decryptedUserInfoName;
  }
}
