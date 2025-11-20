import 'package:dio/dio.dart';

class NetworkClient {
  static final NetworkClient _instance = NetworkClient.init();
  factory NetworkClient() => _instance;

  late final Dio dio;

  NetworkClient.init() {
    final key = const String.fromEnvironment('PLACES');
    if (key.isEmpty) {
      throw AssertionError('youre not wearing a hat!');
    }
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://places.googleapis.com',
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {"X-Goog-Api-Key": key},
      ),
    );

    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
    dio.interceptors.add(ChowInterceptor());
  }

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return dio.get<T>(
      path,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }

  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return dio.post<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }
}

class ChowInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    var headers = {
      'Content-Type': 'application/json',
      'X-Goog-FieldMask':
          'places.displayName,places.formattedAddress,places.currentOpeningHours,places.rating,places.userRatingCount,places.websiteUri',
    };
    options.headers.addAll(headers);
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // Handle responses globally
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    // Handle errors globally
    super.onError(err, handler);
  }
}
