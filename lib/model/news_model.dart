import '../utils/timeline_util.dart';

class NewsModel {
  int id;
  String title;
  String summary;
  int topicId;
  String topicIcon;
  int viewCount;
  int commentCount;
  int diggCount;
  DateTime dateAdded;
  bool isHot;
  bool isRecommend;
  String body;
  String dateDisplay;
  String diggValue;

  NewsModel.fromJson(Map data) {
    id = data['Id'];
    title = data['Title'];
    summary = data['Summary'];
    topicId = data['TopicId'];
    topicIcon = data['TopicIcon'];
    viewCount = data['ViewCount'];
    commentCount = data['CommentCount'];
    diggCount = data['DiggCount'];
    dateAdded = DateTime.parse(data['DateAdded']);
    isHot = false;
    isRecommend = false;
    body = "";
    dateDisplay =
        TimelineUtil.formatByDateTime(this.dateAdded, locale: 'zh').toString();
    diggValue = "$diggCount 推荐 · $commentCount 评论 · $viewCount 阅读";
  }

  Map<String, dynamic> toJson() {
    var jsonMap = new Map<String, dynamic>();
    jsonMap['id'] = this.id;
    jsonMap['title'] = this.title;
    jsonMap['summary'] = this.summary;
    jsonMap['topicId'] = this.topicId;
    jsonMap['topicIcon'] = this.topicIcon;
    jsonMap['viewCount'] = this.viewCount;
    jsonMap['commentCount'] = this.commentCount;
    jsonMap['diggCount'] = this.diggCount;
    jsonMap['dateAdded'] = this.dateAdded?.toIso8601String();
    jsonMap['isHot'] = this.isHot;
    jsonMap['isRecommend'] = this.isRecommend;
    jsonMap['body'] = this.body;
    jsonMap['dateDisplay'] = this.dateDisplay;
    jsonMap['diggValue'] = this.diggValue;

    return jsonMap;
  }
}

class NewsComments {
  int commentID;
  int contentID;
  String commentContent;
  String userGuid;
  int userId;
  String userName;
  String faceUrl;
  int floor;
  DateTime dateAdded;
  int agreeCount;
  int antiCount;
  int parentCommentID;
  NewsComments parentComment;
  String dateDisplay;

  NewsComments.fromJson(Map data) {
    commentID = data['Id'];
    contentID = data['Title'];
    commentContent = data['Summary'];
    userGuid = data['TopicId'];
    userId = data['TopicIcon'];
    userName = data['ViewCount'];
    faceUrl = data['CommentCount'];
    floor = data['DiggCount'];
    dateAdded = DateTime.parse(data['DateAdded']);
    agreeCount = data['AgreeCount'];
    antiCount = data['AntiCount'];
    parentCommentID = data["ParentCommentID"];
    parentComment = data['ParentComment'] != null
        ? NewsComments.fromJson(data["ParentComment"])
        : null;
    dateDisplay =
        TimelineUtil.formatByDateTime(this.dateAdded, locale: 'zh').toString();
  }

  Map<String, dynamic> toJson() {
    var jsonMap = new Map<String, dynamic>();
    jsonMap['commentID'] = this.commentID;
    jsonMap['contentID'] = this.contentID;
    jsonMap['commentContent'] = this.commentContent;
    jsonMap['userGuid'] = this.userGuid;
    jsonMap['userId'] = this.userId;
    jsonMap['userName'] = this.userName;
    jsonMap['faceUrl'] = this.faceUrl;
    jsonMap['floor'] = this.floor;
    jsonMap['dateAdded'] = this.dateAdded?.toIso8601String();
    jsonMap['agreeCount'] = this.agreeCount;
    jsonMap['antiCount'] = this.antiCount;
    jsonMap['parentCommentID'] = this.parentCommentID;
    jsonMap['parentComment'] = this.parentComment;
    jsonMap['dateDisplay'] = this.dateDisplay;

    return jsonMap;
  }
}
