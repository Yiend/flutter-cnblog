// import 'package:flutter/material.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import '../../model/statuses_model.dart';
// import '../../utils/date_util.dart';
// import 'statuses_detail_page.dart';
// import 'statuses_follow_detail_page.dart';


// class StatusesListItem extends StatelessWidget {
//   final String title;
//   final StatusesModel statusesModel;

//   const StatusesListItem({Key key, this.statusesModel,this.title}) : super(key: key);


//  TextEditingController _usernameController;
//   TextEditingController _pwdController;

//   void _tabControllerListener() async {
//     if (_tabController.indexIsChanging) {
//       //判断TabBar是否切换
//       if (_tabController.index > 0 && (await DataUtils.isLogin()) == false) {
//   /*
//          Navigator.push(context, MaterialPageRoute(
//                         //注意传递的参数。goods_list[index]，是吧索引下的goods_date 数据传递了
//                         builder: (context) {
//                       return LoginPage();
//                     }));
//       showDialog(
//             context: context,
//             builder: (_) => LoginDialog(
//                   userNameTextgController: _usernameController,
//                   pwdTextgController: _pwdController,
//                   onCancelButtonPressed: () {
//                     _tabController.animateTo(0); //切换Tabbar
//                     Navigator.of(context).pop();
//                   },
//                   onOkButtonPressed: () {
//                     Navigator.push(context, MaterialPageRoute(
//                         //注意传递的参数。goods_list[index]，是吧索引下的goods_date 数据传递了
//                         builder: (context) {
//                       return LoginPage();
//                     }));
//                   },
//                 ));*/
//       }
//     }
//   }


//   Widget infoItem(IconData icon, String info,String title) {
//     return Row(
//       children: <Widget>[
        
//         Icon(
//           icon,
//           size: 18.0,
//           color: Colors.grey,
//         ),
//         SizedBox(
//           width: 3.0,
//         ),
//         Text(
//           info,
//           style: TextStyle(fontSize: 16.0, color: Colors.grey),
//         ),
//         Text(
//           title,
//           style: TextStyle(fontSize: 16.0, color: Colors.grey),
//         )
//       ],
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 10.0,  //设置阴影
//       // shape: const RoundedRectangleBorder(borderRadius:BorderRadius.only(
//       //       topLeft: Radius.circular(20.0),
//       //       topRight: Radius.zero,
//       //       bottomLeft: Radius.zero,
//       //       bottomRight: Radius.circular(20.0)),
//       // ),  //设置圆角
//       //shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(14.0))),  //设置圆角
//        //对Widget截取的行为，比如这里 Clip.antiAlias 指抗锯齿
//       clipBehavior: Clip.antiAlias,
//       semanticContainer: false,
//       child: Container(
//         width: 200,
//         margin: EdgeInsets.only(left: 15.0,top:20.0,right: 15.0,bottom: 15.0),
//         color: Colors.white,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: <Widget>[
//                 CircleAvatar(
//                   radius: 15.0,
//                   backgroundImage:
//                       CachedNetworkImageProvider(statusesModel.userIconUrl), //头像
//                 ),
//                 SizedBox(
//                   width: 10.0,
//                 ),
//                 Text(
//                   this.statusesModel.userDisplayName, //作者
//                   style: TextStyle(fontSize: 15.0),
//                 ),
//                 // SizedBox(
//                 //    width: 10.0,
//                 // ),
//               ],
//             ),
//             ListTile(
//               title: Text(
//                 statusesModel.contentDisplay==null?"":statusesModel.contentDisplay, //标题
//                 style: TextStyle(
//                   fontSize: 18.0,
//                   color: Colors.black,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               contentPadding: EdgeInsets.symmetric(horizontal: 0.0),
//               onTap: () {
//                 Navigator.push(context, MaterialPageRoute(
//                     //注意传递的参数。goods_list[index]，是吧索引下的goods_date 数据传递了
//                     builder: (context) {
//                   return /*StatusesDetailPage*/StatusesFollowDetailPage(
//                     statusesModel: this.statusesModel,
//                     title:title,
//                   );
//                 }));
//               },
//             ),
//             SizedBox(
//               height: 8.0,
//             ),
//             SizedBox(
//               height: 8.0,
//             ),
//             Row(
//               children: <Widget>[
//                 Expanded(
//                   flex: 4,
//                   child:Text(
//                     DateUtil.getDateStrByDateTime(
//                       this.statusesModel.dateAdded,
//                       format: DateFormat.YEAR_MONTH_DAY_HOUR_MINUTE
//                     ),//时间
//                     style: TextStyle(fontSize: 16, color: Colors.black87),
//                   ),
//                 ),
//                 Expanded(
//                   child: infoItem(
//                     Icons.comment, this.statusesModel.commentCount.toString(),"回复"), //回复数 ,
//                 ),
//                 Expanded(
//                   child:  infoItem(Icons.chat_bubble_outline,
//                     this.statusesModel.commentCount.toString(),"评论"), //评论数,
//                 )
//               ],
//             )
//           ],
//         ),
//     ));
//   }
// }
