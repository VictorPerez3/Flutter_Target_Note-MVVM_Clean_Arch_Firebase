import 'package:encrypt/encrypt.dart' as encrypt;
import '../../../config.dart';
import '../../resources/note/domain/exceptions/decrypt_fail_exception.dart';
import '../dal/data/error_data.dart';

class EncryptionUtil {
  static final _key =
      encrypt.Key.fromUtf8(ConfigEnvironments.getEncryptionKey());
  static final _iv = encrypt.IV.fromUtf8(ConfigEnvironments.getIV());

  static final _encrypter = encrypt.Encrypter(encrypt.AES(_key));

  static String encryptData(String data) {
    final encrypted = _encrypter.encrypt(data, iv: _iv);
    return encrypted.base64;
  }

  static String decryptData(String encryptedData) {
    try {
      final decrypted = _encrypter.decrypt64(encryptedData, iv: _iv);
      return decrypted;
    } catch (e) {
      throw DecryptFailException(
        failure: ErrorData(message: e.toString(), id: 'decrypt_fail'),
      );
    }
  }
}
