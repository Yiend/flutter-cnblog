import 'package:cnblog/common/constants.dart';
import 'package:cnblog/model/enums.dart';
import 'package:cnblog/utils/http_util.dart';
import 'package:cnblog/model/statuses_model.dart';
import 'package:cnblog/utils/sp_util.dart';

class StatusesService {
  /* 
   *获取闪存
   */
  Future<List<StatusesModel>> getStatuses(
      StatusesType type, {int pageIndex, int pageSize=10}) async {
    String statusType = "all";
    switch (type) {
      case StatusesType.all:
        statusType = "all";
        break;
      case StatusesType.following:
        statusType = "following";
        break;
      case StatusesType.my:
        statusType = "my";
        break;
      case StatusesType.mycomment:
        statusType = "mycomment";
        break;
      case StatusesType.recentcomment:
        statusType = "recentcomment";
        break;
      case StatusesType.mention:
        statusType = "mention";
        break;
      case StatusesType.comment:
        statusType = "comment";
        break;
      default:
        statusType = "all";
        break;
    }

    var url =
        "api/statuses/@${statusType}?pageIndex=${pageIndex}&pageSize=${pageSize}&tag=";

    List<StatusesModel> modules = [];

    if (type != StatusesType.all) {
      var result = await HttpUtil.instance.doGet(url);
      result.data.forEach((data) {
        modules.add(StatusesModel.fromJson(data));
      });

      return modules;
    } else {
      var result = await HttpUtil.instance.doGet(url);
      result.data.forEach((data) {
        modules.add(StatusesModel.fromJson(data));
      });

      return modules;
    }
  }

  /* 
   *获取闪存评论
   */
  Future<dynamic> getComments(int id) async {
    var url = "api/statuses/$id/comments";
    var islogin = SpUtil.getBool(CacheKey.is_login);
    
    List<dynamic> modules = [];

    var result = await HttpUtil.instance.doGet(url);

    result.data.forEach((data) {
      var model = StatusesCommentsModel.fromJson(data);
      model.isLoginUser = islogin;
      modules.add(model.toJson());
    });

    return modules;
  }
}
