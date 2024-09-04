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
      'url': '',
    },
    {
      'env': Environments.develop,
      'url': '',
    },
    {
      'env': Environments.staging,
      'url': '',
    },
    {
      'env': Environments.production,
      'url': '',
    },
  ];

  static Map<String, String> getEnvironments() {
    return _availableEnvironments.firstWhere(
          (d) => d['env'] == _currentEnvironments,
    );
  }
}