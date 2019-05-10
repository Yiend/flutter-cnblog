import 'package:cnblog/blocs/bloc_provider.dart';
import 'package:cnblog/blocs/home_bloc.dart';
import 'package:cnblog/model/enums.dart';
import 'package:cnblog/widgets/blog_item.dart';
import 'package:cnblog/widgets/refresh_scaffold.dart';
import 'package:cnblog/widgets/widget_package.dart';
import 'package:cnblog/model/article_model.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

bool isHomeInit = true;

class HomeBlogPage extends StatelessWidget {
  const HomeBlogPage({Key key, this.labId}) : super(key: key);
  final String labId;

  @override
  Widget build(BuildContext context) {
    RefreshController _controller = new RefreshController();
    final HomeBloc bloc = BlocProvider.of<HomeBloc>(context);

    bloc.eventStream.listen((event) {
      if (labId == event.labId) {
        switch (event.type) {
          case RefreshType.refresh:
            if (event.status == RefreshStatus.failed.index) {
              _controller.refreshFailed();
            }
            if (event.status == RefreshStatus.completed.index) {
              _controller.refreshCompleted();
            }
            break;
          case RefreshType.load:
            if (event.status == LoadStatus.noMore.index) {
              _controller.loadNoData();
            }
            if (event.status == LoadStatus.idle.index) {
              _controller.loadComplete();
            }
            break;
          default:
        }
      }
    });

    if (isHomeInit) {
      isHomeInit = false;
      Observable.just(1).delay(new Duration(milliseconds: 500)).listen((_) {
        bloc.onRefresh(labId: labId);
      });
    }

    return new StreamBuilder(
        stream: bloc.articleBlogStream,
        builder:
            (BuildContext context, AsyncSnapshot<List<ArticleModel>> snapshot) {
          return new RefreshScaffold(
            labId: labId,
            isLoading: snapshot.data == null,
            controller: _controller,
            onRefresh: () {
              return bloc.onRefresh(labId: labId);
            },
            onLoadMore: () {
              bloc.onLoadMore(labId: labId);
            },
            itemCount: snapshot.data == null ? 0 : snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              var model = snapshot.data[index];
              return BlogItem(article: model, labId: labId);
            },
          );
        });
  }
}

/*
class HomeBlogPage extends StatefulWidget {
  @override
  _HomeBlogState createState() => _HomeBlogState();
}

class _HomeBlogState extends State<HomeBlogPage> {
  List<ArticleModel> modules = []; //列表数据
  int page = 1; //加载的页码
  ScrollController _scrollController = new ScrollController(); //listview的控制器
  bool isLoading = false; //是否正在加载数据

  Future<List<ArticleModel>> fakeRequest() async {
    var modules = await BlogService().getHomeArticles(this.page, 10);
    return Future.delayed(Duration(milliseconds: 300), () {
      return modules;
    });
  }

  /* 
   下拉刷新
  */
 Future<void> _onRefresh() async {
    var modules = await BlogService().getHomeArticles(1, 10);
    await Future.delayed(Duration(milliseconds: 300), () {
      setState(() {
        this.modules = modules;
      });
    });
  }

  /* 
  上拉加载更多
 */
  _getMoreData() async {
    if (!isLoading) {
      setState(() => isLoading = true);

      List<ArticleModel> newEntries = await fakeRequest(); //returns empty list
      if (newEntries.isEmpty) {
        double edge = 50.0;
        double offsetFromBottom = _scrollController.position.maxScrollExtent -
            _scrollController.position.pixels;
        if (offsetFromBottom < edge) {
          _scrollController.animateTo(
              _scrollController.offset - (edge - offsetFromBottom),
              duration: new Duration(milliseconds: 500),
              curve: Curves.easeOut);
        }
      }
      setState(() {
        modules.addAll(newEntries);
        isLoading = false;
        page++;
      });
    }
  }

  /*
  获取第一页的数据
  */
  Future<void> getFirstData() async {
    var modules = await BlogService().getHomeArticles(page, 10);
    setState(() {
      this.modules = modules;
      page++;
    });
  }

  Widget buildModule(BuildContext context, ArticleModel module) {
    return HomeBlogListItem(
      article: module,
      title: Strings.blog,
    );
  }

  Widget _buildProgressIndicator() {
    if (modules.length > 0) {
      return new Padding(
        padding: const EdgeInsets.all(18.0),
        child: new Center(
          child: new Opacity(
            opacity: isLoading ? 1.0 : 0.0,
            child: new CircularProgressIndicator(),
          ),
        ),
      );
    } else {
      return havaNoMore();
    }
  }

  Widget havaNoMore() {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 18.0, bottom: 30.0),
          child: Text(
            "没有更过内容了，去别的地方看看吧(^_^)",
            style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.grey),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: ListView.builder(
        itemCount: modules.length + 1,
        itemBuilder: (BuildContext context, int index) {
          if (index == modules.length) {
            return _buildProgressIndicator();
          } else {
            return buildModule(context, modules[index]);
          }
        },
        controller: _scrollController,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getFirstData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getMoreData();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
*/
