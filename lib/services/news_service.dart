import '../model/news_model.dart';
import '../utils/http_util.dart';


class NewsService{

   /* 
   *分页获取最新新闻
   */
  Future<List<NewsModel>> getLatestNews(int pageIndex, int pageSize) async {
    var url ="api/NewsItems?pageIndex=${pageIndex}&pageSize=${pageSize}";

    var result = await HttpUtil.instance.doGet(url);

    List<NewsModel> modules = [];
    result.data.forEach((data) {
      modules.add(NewsModel.fromJson(data));
    });

    return modules;
  }

  /* 
   *分页获取推荐新闻
   */
  Future<List<NewsModel>> getRecommendNews(int pageIndex, int pageSize) async {
    var url ="api/newsitems/@recommended?pageIndex=${pageIndex}&pageSize=${pageSize}";

    var result = await HttpUtil.instance.doGet(url);

    List<NewsModel> modules = [];
    result.data.forEach((data) {
      modules.add(NewsModel.fromJson(data));
    });

    return modules;
  }

   /* 
   *分页获取本周热门新闻
   */
  Future<List<NewsModel>> getWeekNews(int pageIndex, int pageSize) async {
    var url ="api/newsitems/@hot-week?pageIndex=${pageIndex}&pageSize=${pageSize}";

    var result = await HttpUtil.instance.doGet(url);

    List<NewsModel> modules = [];
    result.data.forEach((data) {
      modules.add(NewsModel.fromJson(data));
    });

    return modules;
  }

  /*
   * 获取文章详情
   */
  Future<String> getNewsContent(int newId) async {
    var url = "api/newsitems/${newId}/body";
    var result = await HttpUtil.instance.doGet(url);
    return result.data;
  }
}