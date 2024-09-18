class AuthErrorStrings {
  final String credentialsMessage;
  final String otherErrorMessage;
  final String emailAlreadyInUseMessage;
  final String invalidEmailMessage;
  final String networkRequestFailedMessage;
  final String passwordsDoNotMatchMessage;

  AuthErrorStrings(
      {required this.credentialsMessage,
      required this.otherErrorMessage,
      required this.emailAlreadyInUseMessage,
      required this.invalidEmailMessage,
      required this.networkRequestFailedMessage,
      required this.passwordsDoNotMatchMessage});
}
