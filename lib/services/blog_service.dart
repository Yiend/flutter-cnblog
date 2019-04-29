import '../utils/http_util.dart';
import '../common/const/apis.dart';

import 'token_service.dart';
import '../model/article_model.dart';

class BlogService {
  /* 
   *分页获取首页文章
   */
  Future<List<ArticleModel>> getHomeArticles(
      int pageIndex, int pageSize) async {
    var url =
        "${Apis.host}${Apis.api}/blogposts/@sitehome?pageIndex=${pageIndex}&pageSize=${pageSize}";
    var result = await HttpUtil.instance.doGet(url);

    List<ArticleModel> modules = [];
    result.data.forEach((data) {
      modules.add(ArticleModel.fromJson(data));
    });

    return modules;
  }

  /*
   * 获取文章详情
   */
  Future<String> getArticleContent(int blogId) async {
    var url = "api/blogposts/${blogId}/body";
    var result = await HttpUtil.instance.doGet(url);
    return result.data;
  }

  /*
   * 分页获取博客评论
   */
  Future<List<ArticlesComments>> getArticleComments(
      String blogApp, int postId, int pageIndex, int pageSize) async {
    var url =
        "${Apis.host}${Apis.api}/blogs/${blogApp}/posts/${postId}/comments?pageIndex=${pageIndex}&pageSize=${pageSize}";
    var result = await HttpUtil.instance.doGet(url);

    List<ArticlesComments> modules = [];
    result.data.forEach((data) {
      modules.add(ArticlesComments.fromJson(data));
    });

    return modules;
  }

  /*
  * 分页获取精华文章
  */
  Future<List<ArticleModel>> getPickedArticles(
      int pageIndex, int pageSize) async {
    var url =
        "${Apis.host}${Apis.api}/blogposts/@picked?pageIndex=${pageIndex}&pageSize=${pageSize}";
    var result = await HttpUtil.instance.doGet(url);

    List<ArticleModel> modules = [];
    result.data.forEach((data) {
      modules.add(ArticleModel.fromJson(data));
    });

    return modules;
  }

  /*
  * 分页获取知识库文章
  */
  Future<List<KbArticle>> getKnowledgeArticles(
      int pageIndex, int pageSize) async {
    var url =
        "${Apis.host}${Apis.api}/KbArticles?pageIndex=${pageIndex}&pageSize=${pageSize}";
    var result = await HttpUtil.instance.doGet(url);

    List<KbArticle> modules = [];
    result.data.forEach((data) {
      modules.add(KbArticle.fromJson(data));
    });

    return modules;
  }
  
  /*
   * 获取知识库文章详情
   */
  Future<String> getKbArticleContent( int blogId) async {
     var url = "api/kbarticles/${blogId}/body";
    var result = await HttpUtil.instance.doGet(url);
    return result.data;
  }
}
