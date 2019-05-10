import 'dart:io';
import 'package:dio/dio.dart';
import 'package:cnblog/common/constants.dart';
import '../model/token_model.dart';
import '../utils/data_util.dart';

class HttpUtil {
  Dio _dio;
  Dio _tokenDio;
  BaseOptions options;
  static final _baseUrl = AppConfig.host;
  static final _jsonContentType = ContentType.parse("application/json");
  static final _formContentType =
      ContentType.parse("application/x-www-form-urlencoded");
  static String token;

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

      if (token == null) {
        _dio.interceptors.requestLock.lock();

        Map<String, String> map = new Map();
        map['grant_type'] = 'client_credentials';
        map['client_id'] = AppConfig.clientId;
        map['client_secret'] = AppConfig.clientSecret;

         var option = new Options(contentType: _formContentType);
        return _tokenDio.post(AppConfig.clientToken, data: map,options: option).then((result) {

           var tokenModel = TokenModel.fromJson(result.data);
            if (tokenModel != null) {
               token =tokenModel.access_token;
              DataUtils.setToken(tokenModel);
            }

          options.headers["Authorization"] = 'Bearer ${token}';
          return options;
        }).whenComplete(() => _dio.interceptors.requestLock.unlock()); // unlock the dio

      }else{
          options.headers["Authorization"] = 'Bearer ${token}';
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
  }

  static final LogicError unknowError = LogicError(-1, "未知异常");


  Future<dynamic> doGet(String uri, {Map<String, dynamic> headers = null}) {
    var option = new Options();
    if (headers != null) {
      option.headers = headers;
    }
    return _dio.getUri(Uri.parse(uri), options: option);
  }

  Future<dynamic> getJson<T>(String uri,
          {Map<String, dynamic> paras, Map<String, dynamic> headers = null}) =>
      _doHttp("get", uri, _jsonContentType, data: paras, headers: headers)
          .then(logicalErrorTransform);

  Future<dynamic> getForm<T>(String uri,
          {Map<String, dynamic> paras, Map<String, dynamic> headers = null}) =>
      _doHttp("get", uri, _formContentType, data: paras, headers: headers)
          .then(logicalErrorTransform);

  /// 表单方式的post
  Future<Response> postForm<T>(String uri,
          {Map<String, dynamic> paras, Map<String, dynamic> headers = null}) =>
      _doHttp("post", uri, _formContentType, data: paras, headers: headers)
          .then(logicalErrorTransform);

  /// requestBody (json格式参数) 方式的 post
  Future<Response> postJson(String uri,
          {Map<String, dynamic> body, Map<String, dynamic> headers = null}) =>
      _doHttp("post", uri, _jsonContentType, data: body, headers: headers)
          .then(logicalErrorTransform);

  Future<Response> deleteJson<T>(String uri,
          {Map<String, dynamic> body, Map<String, dynamic> headers = null}) =>
      _doHttp("delete", uri, _jsonContentType, data: body)
          .then(logicalErrorTransform);

  /// requestBody (json格式参数) 方式的 put
  Future<Response> putJson<T>(String uri,
          {Map<String, dynamic> body, Map<String, dynamic> headers = null}) =>
      _doHttp("put", uri, _jsonContentType, data: body, headers: headers)
          .then(logicalErrorTransform);

  /// 表单方式的 put
  Future<Response> putForm<T>(String uri,
          {Map<String, dynamic> body, Map<String, dynamic> headers = null}) =>
      _doHttp("put", uri, _formContentType, data: body, headers: headers)
          .then(logicalErrorTransform);

  Future<Response<Map<String, dynamic>>> _doHttp(
      String method, String uri, ContentType contentType,
      {Map<String, dynamic> data, Map<String, dynamic> headers = null}) {
    var option = new Options(method: method, contentType: contentType);

    if (headers != null) {
      option.headers = headers;
    }

    return _dio.request<Map<String, dynamic>>(uri, data: data, options: option);
  }

  /// 对请求返回的数据进行统一的处理
  /// 如果成功则将我们需要的数据返回出去，否则进异常处理方法，返回异常信息
  static Future<Response> logicalErrorTransform(Response resp) {
    return Future.value(resp);

    /*
    if (resp.data != null) {
      if (resp.data["code"] == 0) {
        T realData = resp.data["data"];
        return Future.value(realData);
      }
    }

    if (debug) {
      print('resp--------$resp');
      print('resp.data--------${resp.data}');
    }
    LogicError error;
    if (resp.data != null && resp.data["code"] != 0) {
      if (resp.data['data'] != null) {
        /// 失败时  错误提示在 data中时
        /// 收到token过期时  直接进入登录页面
        Map<String, dynamic> realData = resp.data["data"];
        error = new LogicError(resp.data["code"], realData['codeMessage']);
      } else {
        /// 失败时  错误提示在 message中时
        error = new LogicError(resp.data["code"], resp.data["message"]);
      }

      /// token失效 重新登录  后端定义的code码
      if (resp.data["code"] == 10000000) {
//        NavigatorUtils.goPwdLogin(context);

      }
      if (resp.data["code"] == 80000000) {
        //操作逻辑
      }
    } else {
      error = unknowError;
    }
    return Future.error(error);
    */
  }
}

class LogicError {
  int errorCode;
  String msg;

  LogicError(errorCode, msg) {
    this.errorCode = errorCode;
    this.msg = msg;
  }
}

enum ContentTypes { json, form, file }
