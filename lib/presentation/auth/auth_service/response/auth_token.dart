class AuthToken {
  final String? authToken;
  AuthToken({this.authToken});

  factory AuthToken.fromJson(String auth) =>
      AuthToken(authToken: auth);

}