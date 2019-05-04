import '../common/const/enums.dart';
import '../utils/http_util.dart';
import '../model/statuses_model.dart';

class StatusesService {
  /* 
   *获取闪存
   */
  Future<List<StatusesModel>> getStatuses(
      StatusesType type, int pageIndex, int pageSize) async {
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

    print(url);

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
}
