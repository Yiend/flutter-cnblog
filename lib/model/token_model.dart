class TokenModel {
  TokenModel();

  String access_token;
  int expires_in;
  String token_type;
  bool isIdentityUser;
  DateTime refreshTime;

  TokenModel.fromJson(Map data) {
    access_token = data['access_token'];
    expires_in = data['expires_in'];
    token_type = data['token_type'];
  }

  Map<String, dynamic> toJson() {
     var jsonMap = new Map<String, dynamic>();
    jsonMap['access_token'] = this.access_token;
    jsonMap['expires_in'] = this.expires_in;
    jsonMap['token_type'] = this.token_type;
    
    return jsonMap;
  }


  bool CheckTokenIsOverdue() {
    var a = DateTime.now().second;
    var b = refreshTime.second + expires_in;
    return a > b;
  }
}
