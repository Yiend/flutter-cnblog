import '../utils/http_util.dart';
import '../common/const/apis.dart';
import '../utils/data_util.dart';
import '../model/token_model.dart';

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
    map['client_id'] = Apis.clientId;
    map['client_secret'] = Apis.clientSecret;

    var result =
        await HttpUtil.instance.postForm<TokenModel>(Apis.clientToken, paras: map);
    var tokenModel = TokenModel.fromJson(result.data);

    if (tokenModel != null) {
      DataUtils.setToken(tokenModel);
      return tokenModel.access_token;
    }
    return "";
  }
  
}
