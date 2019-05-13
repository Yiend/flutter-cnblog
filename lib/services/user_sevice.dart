import 'dart:convert';

import 'package:cnblog/model/userinfo_model.dart';
import 'package:cnblog/utils/http_util.dart';
import 'package:cnblog/common/constants.dart';
import '../model/token_model.dart';

class UserService {
  /* 
   *登录
   */
  Future<TokenModel> login(String userName, String passWord) async {
    var url = "token";

    var map = new Map<String, String>();
    map["grant_type"] = "password";
    map["username"] = userName;
    map["password"] = passWord;

    var auth = "${AppConfig.clientId}:${AppConfig.clientSecret}";
    var bytes = utf8.encode(auth);
    var encodedStr = base64Encode(bytes);

    var result = await HttpUtil.instance.postForm(url,
        paras: map, headers: {"Authorization": "Basic " + encodedStr});

    var module = TokenModel.fromJson(result.data);
    print(result.data);
    module.refreshTime = DateTime.now();
    return module;
  }

 Future<UserInfo> getUserInfo() async {
    var url = "api/users";
    var result = await HttpUtil.instance.doGet(url);

    var module = UserInfo.fromJson(result.data);
    print(result.data);
    return module;
  }


}
