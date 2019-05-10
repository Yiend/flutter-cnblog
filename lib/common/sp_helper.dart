

import 'package:cnblog/utils/sp_util.dart';
import 'package:cnblog/model/language_model.dart';

class SpHelper {
  static void setObject<T>(String key, Object value) {
    switch (T) {
      case int:
        SpUtil.setInt(key, value);
        break;
      case double:
        SpUtil.setDouble(key, value);
        break;
      case bool:
        SpUtil.setBool(key, value);
        break;
      case String:
        SpUtil.setString(key, value);
        break;
      case List:
        SpUtil.setStringList(key, value);
        break;
      default:
        SpUtil.setObject(key, value);
        break;
    }
  }

  static Object getObject<T>(String key) {
    Map map = SpUtil.getObject(key);
    if (map == null) return null;
    Object obj;
    switch (T) {
      case LanguageModel:
        obj = LanguageModel.fromJson(map);
        break;
      default:
        break;
    }
    return obj;
  }
}
