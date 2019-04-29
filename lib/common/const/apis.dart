class Apis {
  static const String clientId = "a20de70e-e895-434a-a930-fbbfd8243e66";
  static const String clientSecret = "huep98NbwvOooglPXUnKjJF8tjqvQ-jHujPg5XdJrnf4ptkthgBOXsdYfHExvrqvTqCsufY7J8rj9f7k";

  static const String host = "https://api.cnblogs.com/";
  static const String api = "api";
  static const String clientToken = "token";

  static const String token = "https://oauth.cnblogs.com/connect/token";

  static const String authorize =
      "https://oauth.cnblogs.com/connect/authorize?client_id={0}&scope=openid+profile+CnBlogsApi+offline_access&response_type=code+id_token&redirect_uri=https://oauth.cnblogs.com/auth/callback&state=cnblogs.com&nonce=cnblogs.com";

  static const String users = "${api}/Users";

  static const String blogApp = "${api}/blogs/{0}";
  static const String blogPosts ="${api}/blogs/{0}/posts?pageIndex={1}&pageSize={2}";

  static const String articleHome = "${api}/blogposts/@sitehome?pageIndex={0}&pageSize={1}";


  static const String articleHot =
      "${api}/blogposts/@picked?pageIndex={0}&pageSize={1}";


  static const String articleBody = "${api}/blogposts/{0}/body";
  static const String articleComment =
      "${api}/blogs/{0}/posts/{1}/comments?pageIndex={2}&pageSize={3}";
  static const String articleCommentAdd = "${api}/blogs/{0}/posts/{1}/comments";

  static const String news = "${api}/NewsItems?pageIndex={0}&pageSize={1}";
  static const String newsHome = "${api}/newsitems?pageIndex={0}&pageSize={1}";
  static const String newsRecommend =
      "${api}/newsitems/@recommended?pageIndex={0}&pageSize={1}";
  static const String newsWorkHot =
      "${api}/newsitems/@hot-week?pageIndex={0}&pageSize={1}";
  static const String newsBody = "${api}/newsitems/{0}/body";
  static const String newsComment =
      "${api}/news/{0}/comments?pageIndex={1}&pageSize={2}";
  static const String newsCommentAdd = "${api}/news/{0}/comments";
  static const String newsCommentEdit = "${api}/newscomments/{0}";

  static const String kbArticles =
      "${api}/KbArticles?pageIndex={0}&pageSize={1}";
  static const String kbArticlesBody = "${api}/kbarticles/{0}/body";

  static const String status =
      "${api}/statuses/@{0}?pageIndex={1}&pageSize={2}&tag=";
  static const String statusBody = "${api}/statuses/{0}";
  static const String statusADD = "${api}/statuses";
  static const String statusDelete = "${api}/statuses/{0}";
  static const String statusComments = "${api}/statuses/{0}/comments";
  static const String statusCommentAdd = "${api}/statuses/{0}/comments";
  static const String statusCommentDelete = "${api}/statuses/{0}/comments/{1}";

  static const String questions =
      "${api}/questions/@sitehome?pageIndex={0}&pageSize={1}";
  static const String questionsType =
      "${api}/questions/@{0}?pageIndex={1}&pageSize={2}";
  static const String questionADD = "${api}/questions";
  static const String questionDetails = "${api}/questions/{0}";
  static const String questionEdit = "${api}/questions/{0}";
  static const String questionsAnswers = "${api}/questions/{0}/answers";
  static const String questionsAnswerByUser = "${api}/questions/{0}?userId={1}";
  static const String questionsAnswerAdd = "${api}/questions/{0}/answers";
  static const String questionsAnswerEdit = "${api}/questions/{0}/answers/{1}";
  static const String questionsAnswerComments =
      "${api}/questions/answers/{0}/comments";
  static const String questionsAnswerCommentsAdd =
      "${api}/questions/{0}/answers/{1}/comments";
  static const String questionsAnswerCommentsEdit =
      "${api}/questions/{0}/answers/{1}/comments/{2}";

  static const String bookmarks = "${api}/Bookmarks?pageIndex={0}&pageSize={1}";
  static const String bookmarkHead = "${api}/Bookmarks?url={0}";
  static const String bookmarkEdit = "${api}/bookmarks/{0}";
  static const String bookmarkAdd = "${api}/Bookmarks";

  static const String search =
      "${host}${api}/ZzkDocuments/{0}?keyWords={1}&pageIndex={2}&startDate=&endDate=&viewTimesAtLeast=0";
}
