class TokenModel {
  TokenModel();

  String access_token;
  int expires_in;
  String token_type;

  TokenModel.fromJson(Map data) {
    access_token = data['access_token'];
    expires_in = data['expires_in'];
    token_type = data['token_type'];
  }
}
