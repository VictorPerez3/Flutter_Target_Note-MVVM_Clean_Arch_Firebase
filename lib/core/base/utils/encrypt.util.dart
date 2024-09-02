import 'package:encrypt/encrypt.dart' as encrypt;

import '../../resources/note/domain/exceptions/decrypt_fail.exception.dart';
import '../dal/data/error.data.dart';

class EncryptionUtil {
  // Chave de criptografia fixa
  static final _key = encrypt.Key.fromUtf8('my32lengthsupersecretnooneknows1');

  // IV (Vetor de Inicialização) fixo
  static final _iv = encrypt.IV.fromUtf8('8bytesiv12345678');

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
          failure: ErrorData(message: e.toString(), id: 'decrypt_fail'));
    }
  }
}
