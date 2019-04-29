import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../model/article_model.dart';
import 'home_blog_detail_page.dart';
import 'home_blog_detail_page1.dart';

class HomeBlogListItem extends StatelessWidget {
  final String title;
  final ArticleModel article;

  const HomeBlogListItem({Key key, this.article,this.title}) : super(key: key);

  Widget infoItem(IconData icon, String info) {
    return Row(
      children: <Widget>[
        Icon(
          icon,
          size: 18.0,
          color: Colors.grey,
        ),
        SizedBox(
          width: 3.0,
        ),
        Text(
          info,
          style: TextStyle(fontSize: 16.0, color: Colors.grey),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container(
      padding: EdgeInsets.all(10.0),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ListTile(
            title: Text(
              article.title, //标题
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 0.0),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                  //注意传递的参数。goods_list[index]，是吧索引下的goods_date 数据传递了
                  builder: (context) {
                return HomeBlogDetailPage1(
                  articleModel: this.article,
                  title:title,
                );
              }));
            },
          ),
          SizedBox(
            height: 8.0,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: 15.0,
                backgroundImage:
                    CachedNetworkImageProvider(article.avatar), //头像
              ),
              SizedBox(
                width: 10.0,
              ),
              Text(
                this.article.author, //作者
                style: TextStyle(fontSize: 15.0),
              ),
              // SizedBox(
              //    width: 10.0,
              // ),
            ],
          ),
          Text(
            "${this.article.description.substring(0, 50)}...", //简介
            overflow: TextOverflow.visible,
            style: TextStyle(
              fontSize: 15.0,
              color: Colors.grey,
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
          Text(
            this.article.postDate.toString(), //时间
            style: TextStyle(fontSize: 16, color: Colors.black87),
          ),
          SizedBox(
            height: 8.0,
          ),
          Row(
            children: <Widget>[
              infoItem(
                  Icons.navigation, this.article.viewCount.toString()), //浏览数
              SizedBox(
                width: 10.0,
              ),
              infoItem(Icons.chat_bubble_outline,
                  this.article.commentCount.toString()), //评论数
            ],
          )
        ],
      ),
    ));
  }
}
