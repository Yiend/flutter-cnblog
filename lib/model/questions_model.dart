import 'package:cnblog/common/constants.dart';
import 'package:cnblog/utils/timeline_util.dart';

class Questions {
  int qid;
  String title;
  int dealFlag;
  int viewCount;
  String summary;
  String content;
  DateTime dateAdded;
  String supply;
  String convertedContent;
  int formatType;
  String tags;
  int answerCount;
  int userId;
  int award;
  int diggCount;
  int buryCount;
  bool isBest;
  String answerUserId;
  int flags;
  String dateEnded;
  int userInfoID;
  QuestionUserInfo questionUserInfo;
  int additionID;
  QuestionAddition addition;
  String dateDisplay;
  String tagsDisplay;
  String diggValue;
  String contentDisplay;

  Questions.fromJson(Map data) {
    qid = data['Qid'];
    title = data['Title'];
    dealFlag = data['DealFlag'];
    viewCount = data['ViewCount'];
    summary = data['Summary'];
    content = data['Content'];
    dateAdded = DateTime.parse(data['DateAdded']);
    supply = data['Supply'];
    convertedContent = data['ConvertedContent'];
    formatType = data['FormatType'];
    tags = data['Tags'];
    answerCount = data["AnswerCount"];
    userId = data['UserId'];
    award = data["Award"];
    diggCount = data['DiggCount'];
    buryCount = data["BuryCount"];
    isBest = data['IsBest'];
    answerUserId = data["AnswerUserId"];
    flags = data['Flags'];
    dateEnded = data["DateEnded"];
    userInfoID = data['UserInfoID'];
    questionUserInfo = data["QuestionUserInfo"] != null
        ? QuestionUserInfo.fromJson(data["QuestionUserInfo"])
        : null;
    additionID = data['AdditionID'];
    addition = data["Addition"] != null
        ? QuestionAddition.fromJson(data["Addition"])
        : null;
    dateDisplay =
        TimelineUtil.formatByDateTime(this.dateAdded, locale: 'zh').toString();

    tagsDisplay = tags == null ? "" : tags.replaceAll(',', ' ');
    diggValue = "$diggCount 推荐 ·   $answerCount   回答 ·   $viewCount   阅读";
    contentDisplay = addition != null
        ? content += "<h2>问题补充：</h2>" + addition.content
        : content;
  }

  Map<String, dynamic> toJson() {
    var jsonMap = new Map<String, dynamic>();
    jsonMap['qid'] = this.qid;
    jsonMap['title'] = this.title;
    jsonMap['dealFlag'] = this.dealFlag;
    jsonMap['viewCount'] = this.viewCount;
    jsonMap['summary'] = this.summary;
    jsonMap['content'] = this.content;
    jsonMap['dateAdded'] = this.dateAdded?.toIso8601String();
    jsonMap['supply'] = this.supply;
    jsonMap['convertedContent'] = this.convertedContent;
    jsonMap['formatType'] = this.formatType;
    jsonMap['tags'] = this.tags;
    jsonMap['answerCount'] = this.answerCount;
    jsonMap['userId'] = this.userId;
    jsonMap['award'] = this.award;
    jsonMap['diggCount'] = this.diggCount;
    jsonMap['buryCount'] = this.buryCount;
    jsonMap['isBest'] = this.isBest;
    jsonMap['flags'] = this.flags;
    jsonMap['dateEnded'] = this.dateEnded;
    jsonMap['userInfoID'] = this.userInfoID;
    jsonMap['questionUserInfo'] = this.questionUserInfo.toJson();
    jsonMap['additionID'] = this.additionID;
    jsonMap['addition'] = this.addition.toJson();
    jsonMap['dateDisplay'] = this.dateDisplay;
    jsonMap['tagsDisplay'] = this.tagsDisplay;
    jsonMap['diggValue'] = this.diggValue;
    jsonMap['contentDisplay'] = this.contentDisplay;

    return jsonMap;
  }
}

class QuestionUserInfo {
  int userID;
  String userName;
  String loginName;
  String userEmail;
  String iconName;
  String alias;
  int qScore;
  String qScoreName;
  DateTime dateAdded;
  int userWealth;
  bool isActive;
  String uCUserID;
  String iconDisplay;

  QuestionUserInfo.fromJson(Map data) {
    userID = data['UserID'];
    userName = data['UserName'];
    loginName = data['LoginName'];
    userEmail = data['UserEmail'];
    iconName = data['IconName'];
    alias = data['Alias'];
    qScore = data['QScore'];
    qScoreName = HtmlTemplate.getScoreName(qScore);
    dateAdded = DateTime.parse(data['DateAdded']);
    userWealth = data['UserWealth'];
    isActive = data['IsActive'];
    uCUserID = data["UCUserID"];
    iconDisplay = iconName.indexOf('https://') > -1
        ? iconName
        : "https://pic.cnblogs.com/face/$iconName";
  }

  Map<String, dynamic> toJson() {
    var jsonMap = new Map<String, dynamic>();
    jsonMap['userID'] = this.userID;
    jsonMap['userName'] = this.userName;
    jsonMap['loginName'] = this.loginName;
    jsonMap['userEmail'] = this.userEmail;
    jsonMap['iconName'] = this.iconName;
    jsonMap['alias'] = this.alias;
    jsonMap['qScore'] = this.qScore;
    jsonMap['qScoreName'] = this.qScoreName;
    jsonMap['dateAdded'] = this.dateAdded?.toIso8601String();
    jsonMap['userWealth'] = this.userWealth;
    jsonMap['isActive'] = this.isActive;
    jsonMap['uCUserID'] = this.uCUserID;
    jsonMap['iconDisplay'] = this.iconDisplay;

    return jsonMap;
  }
}

class QuestionAddition {
  int qID;
  String content;
  String convertedContent;

  QuestionAddition.fromJson(Map data) {
    qID = data['QID'];
    content = data['Content'];
    convertedContent = data['ConvertedContent'];
  }

  Map<String, dynamic> toJson() {
    var jsonMap = new Map<String, dynamic>();
    jsonMap['qID'] = this.qID;
    jsonMap['content'] = this.content;
    jsonMap['convertedContent'] = this.convertedContent;

    return jsonMap;
  }
}
