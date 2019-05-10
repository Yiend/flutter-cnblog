import 'package:flutter/material.dart';
import '../../../model/article_model.dart';
import 'home_knowledge_detail_page.dart';
import '.././../../utils/date_util.dart';

class HomeKnowledgeListItem extends StatelessWidget {
  final String title;
  final KbArticle article;

  const HomeKnowledgeListItem({Key key, this.article, this.title})
      : super(key: key);

  Widget infoItem(IconData icon, String info,String tip) {
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
        ),
        Text(
          tip,
          style: TextStyle(fontSize: 16.0, color: Colors.grey),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10.0,  //设置阴影
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
                return HomeKnowledgeDetailPage(
                  articleModel: this.article,
                  title: title,
                );
              })
            );
            },
          ),
          SizedBox(
            height: 2.0,
          ),
          Text(
            this.article.author==null?"":this.article.author, //作者
            style: TextStyle(fontSize: 15.0),
          ),
          Text(
            this.article.summary==null?"":this.article.summary, //简介
            overflow: TextOverflow.visible,
            style: TextStyle(
              fontSize: 15.0,
              color: Colors.grey,
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
          Row(
            children: <Widget>[
              Expanded(
                flex: 4,
                child: Text(
                    DateUtil.getDateStrByDateTime(
                      this.article.dateAdded,
                      format: DateFormat.YEAR_MONTH_DAY_HOUR_MINUTE
                    ),//时间
                   style: TextStyle(fontSize: 16, color: Colors.black87),
                ),
              ),
              Expanded(
                flex:3,
                child: Row(
                  children: <Widget>[
                       infoItem(Icons.play_arrow,
                            this.article.viewCount.toString(),"浏览"), //浏览数
                       infoItem(
                            Icons.arrow_upward, this.article.diggCount.toString(),"推荐"), //推荐
                      
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    ));
  }
}
