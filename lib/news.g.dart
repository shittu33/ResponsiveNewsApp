// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsApiResult _$NewsApiResultFromJson(Map<String, dynamic> json) {
  return NewsApiResult(
    status: json['status'] as String,
    totalResults: json['totalResults'] as int,
    articles: (json['articles'] as List)
        ?.map((e) =>
            e == null ? null : Article.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$NewsApiResultToJson(NewsApiResult instance) =>
    <String, dynamic>{
      'status': instance.status,
      'totalResults': instance.totalResults,
      'articles': instance.articles?.map((e) => e?.toJson())?.toList(),
    };

Article _$ArticleFromJson(Map<String, dynamic> json) {
  return Article(
    source: json['source'] == null
        ? null
        : Source.fromJson(json['source'] as Map<String, dynamic>),
    author: json['author'] as String,
    title: json['title'] as String,
    description: json['description'] as String,
    url: json['url'] as String,
    urlToImage: json['urlToImage'] as String,
    publishedAt: json['publishedAt'] as String,
    content: json['content'] as String,
  );
}

Map<String, dynamic> _$ArticleToJson(Article instance) => <String, dynamic>{
      'source': instance.source?.toJson(),
      'author': instance.author,
      'title': instance.title,
      'description': instance.description,
      'url': instance.url,
      'urlToImage': instance.urlToImage,
      'publishedAt': instance.publishedAt,
      'content': instance.content,
    };

Source _$SourceFromJson(Map<String, dynamic> json) {
  return Source(
    json['id'] as String,
    json['name'] as String,
  );
}

Map<String, dynamic> _$SourceToJson(Source instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

SourcesResult _$SourcesResultFromJson(Map<String, dynamic> json) {
  return SourcesResult(
    status: json['status'] as String,
    sources: (json['sources'] as List)
        ?.map((e) =>
            e == null ? null : Source.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$SourcesResultToJson(SourcesResult instance) =>
    <String, dynamic>{
      'status': instance.status,
      'sources': instance.sources?.map((e) => e?.toJson())?.toList(),
    };

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _NewsClient implements NewsClient {
  _NewsClient(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    this.baseUrl ??= 'https://newsapi.org/v2/';
  }

  final Dio _dio;

  String baseUrl;

  @override
  getNews() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/top-headlines?category=general&apiKey=52c90e67f4164e4f8cadab7c05274ea8',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = NewsApiResult.fromJson(_result.data);
    return value;
  }

  @override
  getNewsByCountry(countryId) async {
    ArgumentError.checkNotNull(countryId, 'countryId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/top-headlines?country=$countryId&apiKey=52c90e67f4164e4f8cadab7c05274ea8',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = NewsApiResult.fromJson(_result.data);
    return value;
  }

  @override
  getNewsSources() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/sources?apiKey=52c90e67f4164e4f8cadab7c05274ea8',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = SourcesResult.fromJson(_result.data);
    return value;
  }

  @override
  getTopNewsBySources(sourceId) async {
    ArgumentError.checkNotNull(sourceId, 'sourceId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/top-headlines?sources=$sourceId&apiKey=52c90e67f4164e4f8cadab7c05274ea8',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = NewsApiResult.fromJson(_result.data);
    return value;
  }

  @override
  getNewsByCategory(categoryId) async {
    ArgumentError.checkNotNull(categoryId, 'categoryId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/top-headlines?category=$categoryId&apiKey=52c90e67f4164e4f8cadab7c05274ea8',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = NewsApiResult.fromJson(_result.data);
    return value;
  }

  @override
  getNewsByContCat(countryId, categoryId) async {
    ArgumentError.checkNotNull(countryId, 'countryId');
    ArgumentError.checkNotNull(categoryId, 'categoryId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/top-headlines?country=$countryId&category=$categoryId&apiKey=52c90e67f4164e4f8cadab7c05274ea8',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = NewsApiResult.fromJson(_result.data);
    return value;
  }

  @override
  getNewsByCategoryLimit(categoryId) async {
    ArgumentError.checkNotNull(categoryId, 'categoryId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/top-headlines?category=$categoryId&pageSize=2&apiKey=52c90e67f4164e4f8cadab7c05274ea8',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = NewsApiResult.fromJson(_result.data);
    return value;
  }

  @override
  getEveryNews(searchedData) async {
    ArgumentError.checkNotNull(searchedData, 'searchedData');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/everything?q=$searchedData&apiKey=52c90e67f4164e4f8cadab7c05274ea8',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = NewsApiResult.fromJson(_result.data);
    return value;
  }

  @override
  getEveryNewsBySources(searchedData, sourceId) async {
    ArgumentError.checkNotNull(searchedData, 'searchedData');
    ArgumentError.checkNotNull(sourceId, 'sourceId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/everything?q=$searchedData&sources=$sourceId&apiKey=52c90e67f4164e4f8cadab7c05274ea8',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = NewsApiResult.fromJson(_result.data);
    return value;
  }

  @override
  getEveryNewsByLang(searchedData, language) async {
    ArgumentError.checkNotNull(searchedData, 'searchedData');
    ArgumentError.checkNotNull(language, 'language');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/everything?q=$searchedData&language=$language&apiKey=52c90e67f4164e4f8cadab7c05274ea8',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = NewsApiResult.fromJson(_result.data);
    return value;
  }

  @override
  getNewsBySourceLang(searchedData, language, sourceId) async {
    ArgumentError.checkNotNull(searchedData, 'searchedData');
    ArgumentError.checkNotNull(language, 'language');
    ArgumentError.checkNotNull(sourceId, 'sourceId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/everything?q=$searchedData&sources=$sourceId&language=$language&apiKey=52c90e67f4164e4f8cadab7c05274ea8',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = NewsApiResult.fromJson(_result.data);
    return value;
  }
}
