import 'dart:convert';

import '../utils/http_util.dart';
import '../model/token_model.dart';

class UserService {
  /* 
   *登录
   */
  Future<void> login(String userName, String passWord) async {
    var url = "token";

    var map = new Map<String, String>();
    map["grant_type"] = "password";
    map["username"] = userName;
    map["password"] = passWord;


    var result = await HttpUtil.instance.postForm(url,paras: map);

    List<TokenModel> modules = [];
    result.data.forEach((data) {
      modules.add(TokenModel.fromJson(data));
    });
  }
}
