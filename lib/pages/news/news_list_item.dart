import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../model/news_model.dart';
import '../../utils/date_util.dart';
import 'news_detail_page.dart';


class NewsListItem extends StatelessWidget {
  final String title;
  final NewsModel newsModel;

  const NewsListItem({Key key, this.newsModel,this.title}) : super(key: key);

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
              newsModel.title==null?"":newsModel.title, //标题
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
                return NewsDetailPage(
                  newsModel: this.newsModel,
                  title:title,
                );
              }));
            },
          ),
          SizedBox(
            height: 8.0,
          ),
          Row(
           crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Image(
                  alignment: Alignment.topCenter,
                  image: CachedNetworkImageProvider(newsModel.topicIcon==null?"":newsModel.topicIcon),
                ),
              ),
              Expanded(
                flex: 0,
                child: SizedBox(width: 3.0),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  this.newsModel.summary==null?"":newsModel.summary,
                  softWrap:true,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 5,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.grey,
                  ),
                ),
              ),
              // CircleAvatar(
              //   radius: 15.0,
              //   backgroundImage:
              //       CachedNetworkImageProvider(newsModel.topicIcon==null?"":newsModel.topicIcon), //头像
              // ),
              SizedBox(
                width: 10.0,
              ),
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          Row(
            children: <Widget>[
              Expanded(
                flex: 4,
                child: Text(
                    DateUtil.getDateStrByDateTime(
                      this.newsModel.dateAdded,
                      format: DateFormat.YEAR_MONTH_DAY_HOUR_MINUTE
                    ),//时间
                  style: TextStyle(fontSize: 16, color: Colors.black87),
                ),
              ),
              Expanded(
                flex: 3,
                child: Row(
                  children: <Widget>[
                      infoItem(
                         Icons.play_arrow, this.newsModel.viewCount.toString(),"浏览"), //浏览数
                      infoItem(Icons.chat_bubble_outline,
                         this.newsModel.commentCount.toString(),"评论"), //评论数
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