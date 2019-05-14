# Flutter版 博客园第三方 App.
如何疑问或BUG 请提 Issue

### 注意
访问博客园API需要申请API KEY,[申请地址](https://oauth.cnblogs.com/)

为了下载项目后能直接运行,已经设置了默认的Key,请申请成功后替换自己的Key.

## App目录结构
>- |--android
>- |--assets (静态资源文件)
>- |--build (编译文件)
>- |--ios
>- |--lib
>    - |-- blocs 
>    - |-- common (公共类，帮助类，例如常量Constant)
>    - |-- components (组件)
>    - |-- model (实体)
>    - |-- pages (界面相关)
>    - |-- resources (资源，strings，colors)
>    - |-- services (服务层)
>    - |-- utils (工具)
>    - |-- widgets (部件，webview,loading,refresh,item ...)
>- |--test

### 网络数据
本项目使用 Dio 进行网络请求。具体实现在 utils --> http_util

```dart
class HttpUtil {
  Dio _dio;
  Dio _tokenDio;
  BaseOptions options;
  static final _baseUrl = AppConfig.host;
  static final _jsonContentType = ContentType.parse("application/json");
  static final _formContentType =
      ContentType.parse("application/x-www-form-urlencoded");

  // 工厂模式
  factory HttpUtil() => _getInstance();
  static HttpUtil get instance => _getInstance();
  static HttpUtil _instance;

  static HttpUtil _getInstance() {
    if (_instance == null) {
      _instance = new HttpUtil._internal();
    }
    return _instance;
  }

  HttpUtil._internal() {
    // 初始化
    options = BaseOptions(
        baseUrl: _baseUrl,
        connectTimeout: 10000,
        receiveTimeout: 5000,
        headers: {},
        followRedirects: true);
    _dio = new Dio(options);
    _tokenDio = new Dio(options);

    //拦截器
    _dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) {
      // 在请求被发送之前做一些事情
      if (options.path.startsWith("token")) {
        return options;
      }

      var sptokenModel = SpHelper.getObject<TokenModel>(CacheKey.access_token);
      if (sptokenModel == null ||sptokenModel.access_token==null) {
        _dio.interceptors.requestLock.lock();

        Map<String, String> map = new Map();
        map['grant_type'] = 'client_credentials';
        map['client_id'] = AppConfig.clientId;
        map['client_secret'] = AppConfig.clientSecret;

        var option = new Options(contentType: _formContentType);
        return _tokenDio
            .post(AppConfig.clientToken, data: map, options: option)
            .then((result) {
          var tokenModel = TokenModel.fromJson(result.data);
          if (tokenModel != null) {
            SpHelper.setObject(CacheKey.access_token, tokenModel.toJson());
          }

          options.headers["Authorization"] = 'Bearer ${tokenModel.access_token}';
          return options;
        }).whenComplete(
                () => _dio.interceptors.requestLock.unlock()); // unlock the dio

      } else {
        options.headers["Authorization"] = 'Bearer ${sptokenModel.access_token}';
        return options; //continue
      }

      // 如果你想完成请求并返回一些自定义数据，可以返回一个`Response`对象或返回`dio.resolve(data)`。
      // 这样请求将会被终止，上层then会被调用，then中返回的数据将是你的自定义数据data.
      //
      // 如果你想终止请求并触发一个错误,你可以返回一个`DioError`对象，或返回`dio.reject(errMsg)`，
      // 这样请求将被中止并触发异常，上层catchError会被调用。
    }, onResponse: (Response response) {
      // 在返回响应数据之前做一些预处理
      return response; // continue
    }, onError: (DioError e) {
      // 当请求失败时做一些预处理
      return e; //continue
    }));
    
    .......
  }

```

