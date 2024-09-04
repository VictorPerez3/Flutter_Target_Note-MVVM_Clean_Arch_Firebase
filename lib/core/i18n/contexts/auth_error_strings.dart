class AuthErrorStrings {
  final String usernameMessage;
  final String passwordMessage;
  final String otherErrorMessage;
  final String emailAlreadyInUseMessage;
  final String invalidEmailMessage;
  final String networkRequestFailedMessage;
  final String passwordsDoNotMatchMessage;

  AuthErrorStrings(
      {required this.usernameMessage,
      required this.passwordMessage,
      required this.otherErrorMessage,
      required this.emailAlreadyInUseMessage,
      required this.invalidEmailMessage,
      required this.networkRequestFailedMessage,
      required this.passwordsDoNotMatchMessage});
}
