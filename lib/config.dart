class Environments {
  static const String production = 'prod';
  static const String staging = 'staging';
  static const String develop = 'dev';
  static const String local = 'local';
}

class ConfigEnvironments {
  static const String _currentEnvironments = Environments.develop;

  static const List<Map<String, String>> _availableEnvironments = [
    {
      'env': Environments.local,
      'url': 'https://local-api-url.com',
      'key': 'my32lengthsupersecretnooneknows1',
      'iv': '8bytesiv12345678',
    },
    {
      'env': Environments.develop,
      'url': 'https://dev-api-url.com',
      'key': 'my32lengthsupersecretnooneknows1',
      'iv': '8bytesiv12345678',
    },
    {
      'env': Environments.staging,
      'url': 'https://staging-api-url.com',
      'key': 'my32lengthsupersecretnooneknows1',
      'iv': '8bytesiv12345678',
    },
    {
      'env': Environments.production,
      'url': 'https://prod-api-url.com',
      'key': 'my32lengthsupersecretnooneknows1',
      'iv': '8bytesiv12345678',
    },
  ];

  static Map<String, String> getEnvironments() {
    return _availableEnvironments.firstWhere(
      (d) => d['env'] == _currentEnvironments,
    );
  }

  static String getEncryptionKey() {
    return getEnvironments()['key']!;
  }

  static String getIV() {
    return getEnvironments()['iv']!;
  }
}
