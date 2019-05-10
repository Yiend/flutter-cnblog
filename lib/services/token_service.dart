import 'package:cnblog/utils/http_util.dart';
import 'package:cnblog/common/constants.dart';
import 'package:cnblog/utils/data_util.dart';
import 'package:cnblog/model/token_model.dart';

class TonkenService {
  Future<String> getClientToken() async {
    var token = await DataUtils.getToken();
    if (token != null &&
        token.access_token != null &&
        (token.access_token.isNotEmpty && token.access_token != "")) {
      return token.access_token;
    }

    Map<String, String> map = new Map();
    map['grant_type'] = 'client_credentials';
    map['client_id'] = AppConfig.clientId;
    map['client_secret'] = AppConfig.clientSecret;

    var result =
        await HttpUtil.instance.postForm<TokenModel>(AppConfig.clientToken, paras: map);
    var tokenModel = TokenModel.fromJson(result.data);

    if (tokenModel != null) {
      DataUtils.setToken(tokenModel);
      return tokenModel.access_token;
    }
    return "";
  }
  
}
