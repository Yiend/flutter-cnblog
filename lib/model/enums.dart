enum StatusesType {
  all,
  following,
  my, 
  mycomment,
  recentcomment,
  mention,
  comment
}

enum LoadMoreStatus{
  stausDefault,
  stausLoading,
  stausNodata,
  stausEnd,
  stausFail,
  stausError,
  stausNologin
}

enum RefreshType{
  refresh,//刷新
  load //加载更多
}