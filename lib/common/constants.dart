class AppConfig {
  static const String clientId = "a20de70e-e895-434a-a930-fbbfd8243e66";
  static const String clientSecret =
      "huep98NbwvOooglPXUnKjJF8tjqvQ-jHujPg5XdJrnf4ptkthgBOXsdYfHExvrqvTqCsufY7J8rj9f7k";
  static const String host = "https://api.cnblogs.com/";
  static const String clientToken = "token";
}

class Constant {
  static const String articleUrl = "assets/articles.html";
  static const String answerUrl = "assets/answers.html";
  static const String kbarticlesUrl = "assets/kbarticles.html";
  static const String newsUrl = "assets/news.html";
  static const String questionUrl = "assets/questions.html";
  static const String statuseUrl = "assets/statuses.html";
}

class HtmlTemplate {
  static String getScoreName(int score) {
    if (score > 100000) {
      return "大牛九级";
    }
    if (score > 50000) {
      return "牛人八级";
    }
    if (score > 20000) {
      return "高人七级";
    }
    if (score > 10000) {
      return "专家六级";
    }
    if (score > 5000) {
      return "大侠五级";
    }
    if (score > 2000) {
      return "老鸟四级";
    }
    if (score > 500) {
      return "小虾三级";
    }
    if (score > 200) {
      return "初学一级";
    }
    return "初学一级";
  }
}

class CacheKey {
  static const String is_login = "isLogin";
  static const String access_token = "access_token";
}
