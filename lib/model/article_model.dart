import '../utils/timeline_util.dart';

class ArticleModel {
  // ArticleModel(
  //     {this.id,
  //     this.title,
  //     this.url,
  //     this.description,
  //     this.author,
  //     this.blogApp,
  //     this.avatar,
  //     this.postDate,
  //     this.viewCount,
  //     this.commentCount,
  //     this.diggCount,
  //     this.nextRefreshTime,
  //     this.body,
  //     this.dateDisplay});

  int id;
  String title;
  String url;
  String description;
  String author;
  String blogApp;
  String avatar;
  DateTime postDate;
  int viewCount;
  int commentCount;
  int diggCount;
  DateTime nextRefreshTime;
  String body;
  String dateDisplay;

  ArticleModel.fromJson(Map data) {
    id = data['Id'];
    title = data['Title'];
    url = data['Url'];
    description = data['Description'];
    author = data['Author'];
    blogApp = data['BlogApp'];
    avatar = data['Avatar'];
    postDate = DateTime.parse(data['PostDate']);
    viewCount = data['ViewCount'];
    commentCount = data['CommentCount'];
    diggCount = data['DiggCount'];
    dateDisplay =
        TimelineUtil.formatByDateTime(this.postDate, locale: 'zh').toString();
  }

  Map<String, dynamic> toJson() {
    var jsonMap = new Map<String, dynamic>();
    jsonMap['id'] = this.id;
    jsonMap['title'] = this.title;
    jsonMap['url'] = this.url;
    jsonMap['description'] = this.description;
    jsonMap['author'] = this.author;
    jsonMap['blogApp'] = this.blogApp;
    jsonMap['avatar'] = this.avatar;
    jsonMap['postDate'] = this.postDate?.toIso8601String();
    jsonMap['viewCount'] = this.viewCount;
    jsonMap['commentCount'] = this.commentCount;
    jsonMap['diggCount'] = this.diggCount;
    jsonMap['nextRefreshTime'] = this.nextRefreshTime?.toIso8601String();
    jsonMap['body'] = this.body;
    jsonMap['dateDisplay'] = this.dateDisplay;

    return jsonMap;
  }
}

class ArticlesComments {
  int id;
  String body;
  String author;
  String authorUrl;
  String faceUrl;
  int floor;
  DateTime dateAdded;
  String dateDisplay;
  String faceUrlDisplay;

  ArticlesComments.fromJson(Map data) {
    id = data['Id'];
    body = data['Body'];
    author = data['Author'];
    authorUrl = data['AuthorUrl'];
    faceUrl = data['FaceUrl'];
    floor = data['Floor'];
    dateAdded = DateTime.parse(data['DateAdded']);
    dateDisplay =
        TimelineUtil.formatByDateTime(this.dateAdded, locale: 'zh').toString();
    faceUrlDisplay = this.faceUrl.isEmpty
        ? "https://pic.cnblogs.com/face/sample_face.gif"
        : this.faceUrl;
  }

  Map<String, dynamic> toJson() {
    var jsonMap = new Map<String, dynamic>();
    jsonMap['id'] = this.id;
    jsonMap['body'] = this.body;
    jsonMap['author'] = this.author;
    jsonMap['authorUrl'] = this.authorUrl;
    jsonMap['faceUrl'] = this.faceUrl;
    jsonMap['floor'] = this.floor;
    jsonMap['dateAdded'] = this.dateAdded?.toIso8601String();
    jsonMap['dateDisplay'] = this.dateDisplay;
    jsonMap['faceUrlDisplay'] = this.faceUrlDisplay;

    return jsonMap;
  }
}

class KbArticle {
  int id;
  String title;
  String summary;
  String author;
  int viewCount;
  int diggCount;
  DateTime dateAdded;
  String dateDisplay;
  String body;

  KbArticle.fromJson(Map data) {
    id = data['Id'];
    title = data['Title'];
    summary = data['Summary'];
    author = data['Author'];
    viewCount = data['ViewCount'];
    diggCount = data['DiggCount'];
    dateAdded = DateTime.parse(data['DateAdded']);
    dateDisplay =
        TimelineUtil.formatByDateTime(this.dateAdded, locale: 'zh').toString();
    body = "";
  }

  Map<String, dynamic> toJson() {
    var jsonMap = new Map<String, dynamic>();
    jsonMap['id'] = this.id;
    jsonMap['title'] = this.title;
    jsonMap['summary'] = this.summary;
    jsonMap['author'] = this.author;
    jsonMap['viewCount'] = this.viewCount;
    jsonMap['diggCount'] = this.diggCount;
    jsonMap['dateAdded'] = this.dateAdded?.toIso8601String();
    jsonMap['dateDisplay'] = this.dateDisplay;
    jsonMap['body'] = this.body;
    return jsonMap;
  }
}
