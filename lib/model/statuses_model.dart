import '../utils/timeline_util.dart';

class StatusesModel {
  int id;
  String content;
  bool isPrivate;
  bool isLucky;
  int commentCount;
  String userAlias;
  String userDisplayName;
  DateTime dateAdded;
  String userIconUrl;
  int userId;
  String userGuid;
  String commentValue;
  String dateDisplay;
  String contentDisplay;
  bool isDelete;

  StatusesModel.fromJson(Map data) {
    id = data['Id'];
    content = data['Content'];
    isPrivate = data['IsPrivate'];
    isLucky = data['IsLucky'];
    commentCount = data['CommentCount'];
    userAlias = data['UserAlias'];
    userDisplayName = data['UserDisplayName'];
    dateAdded = DateTime.parse(data['DateAdded']);
    userIconUrl = data['UserIconUrl'];
    userId = data['UserId'];
    userGuid = data['UserGuid'];
    commentValue = commentCount > 0 ? commentCount.toString() : "回复";
    dateDisplay =
        TimelineUtil.formatByDateTime(this.dateAdded, locale: 'zh').toString();

    contentDisplay = isLucky
        ? "${content}<img src='https://common.cnblogs.com/images/ing/lucky-star-20170120.png' class='ing-icon'/>"
        : content;

    isDelete = false;
  }

  Map<String, dynamic> toJson() {
    var jsonMap = new Map<String, dynamic>();
    jsonMap['id'] = this.id;
    jsonMap['content'] = this.content;
    jsonMap['isPrivate'] = this.isPrivate;
    jsonMap['isLucky'] = this.isLucky;
    jsonMap['commentCount'] = this.commentCount;
    jsonMap['userAlias'] = this.userAlias;
    jsonMap['userDisplayName'] = this.userDisplayName;
    jsonMap['dateAdded'] = this.dateAdded?.toIso8601String();
    jsonMap['userIconUrl'] = this.userIconUrl;
    jsonMap['userId'] = this.userId;
    jsonMap['userGuid'] = this.userGuid;
    jsonMap['commentValue'] = this.commentValue;
    jsonMap['dateDisplay'] = this.dateDisplay;
    jsonMap['contentDisplay'] = this.contentDisplay;
    jsonMap['isDelete'] = this.isDelete;
    return jsonMap;
  }
}


class StatusesCommentsModel {
  int id;
  String content;
  int statusId;
  String userAlias;
  String userDisplayName;
  DateTime dateAdded;
  String userIconUrl;
  int userId;
  String userGuid;
  String dateDisplay;
  bool isLoginUser;

  StatusesCommentsModel.fromJson(Map data) {
    id = data['Id'];
    content = data['Content'];
    statusId = data['StatusId'];
    userAlias = data['UserAlias'];
    userDisplayName = data['UserDisplayName'];
    dateAdded = DateTime.parse(data['DateAdded']);
    userIconUrl = data['UserIconUrl'];
    userId = data['UserId'];
    userGuid = data['UserGuid'];
    dateDisplay =
        TimelineUtil.formatByDateTime(this.dateAdded, locale: 'zh').toString();

    isLoginUser = false;
  }

  Map<String, dynamic> toJson() {
    var jsonMap = new Map<String, dynamic>();
    jsonMap['id'] = this.id;
    jsonMap['content'] = this.content;
    jsonMap['statusId'] = this.statusId;
    jsonMap['userAlias'] = this.userAlias;
    jsonMap['userDisplayName'] = this.userDisplayName;
    jsonMap['dateAdded'] = this.dateAdded?.toIso8601String();
    jsonMap['userIconUrl'] = this.userIconUrl;
    jsonMap['userId'] = this.userId;
    jsonMap['userGuid'] = this.userGuid;
    jsonMap['dateDisplay'] = this.dateDisplay;
    jsonMap['isLoginUser'] = this.isLoginUser;
    return jsonMap;
  }
}