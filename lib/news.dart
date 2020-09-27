import 'package:country_code/country_code.dart';
import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'config.dart';

part 'news.g.dart';

@RestApi(baseUrl: "https://newsapi.org/v2/")
abstract class NewsClient {
  factory NewsClient(Dio dio) = _NewsClient;

  @GET("/top-headlines?category=general&apiKey=$NEWS_API_KEY")
  Future<NewsApiResult> getNews();

  @GET("/top-headlines?country={country}&apiKey=$NEWS_API_KEY")
  Future<NewsApiResult> getNewsByCountry(@Path("country") String countryId);

  @GET("/sources?apiKey=$NEWS_API_KEY") /*bbc-news*/
  Future<SourcesResult> getNewsSources();

  @GET("/top-headlines?sources={sources}&apiKey=$NEWS_API_KEY") /*bbc-news*/
  Future<NewsApiResult> getTopNewsBySources(@Path("sources") String sourceId);

  @GET("/top-headlines?category={category}&apiKey=$NEWS_API_KEY") /*business*/
  Future<NewsApiResult> getNewsByCategory(@Path("category") String categoryId);

  @GET(
      "/top-headlines?country={country}&category={category}&apiKey=$NEWS_API_KEY")
  Future<NewsApiResult> getNewsByContCat(
      @Path("country") String countryId, @Path("category") String categoryId);

  @GET(
      "/top-headlines?category={category}&pageSize=2&apiKey=$NEWS_API_KEY") /*business*/
  Future<NewsApiResult> getNewsByCategoryLimit(
      @Path("category") String categoryId);

  @GET("/everything?q={q}&apiKey=$NEWS_API_KEY") /*bbc-news*/
  Future<NewsApiResult> getEveryNews(@Path("q") String searchedData);

  @GET("/everything?q={q}&sources={sources}&apiKey=$NEWS_API_KEY") /*bbc-news*/
  Future<NewsApiResult> getEveryNewsBySources(
      @Path("q") String searchedData, @Path("sources") String sourceId);

  @GET(
      "/everything?q={q}&language={language}&apiKey=$NEWS_API_KEY") /*bbc-news*/
  Future<NewsApiResult> getEveryNewsByLang(
      @Path("q") String searchedData, @Path("language") String language);

  @GET(
      "/everything?q={q}&sources={sources}&language={language}&apiKey=$NEWS_API_KEY") /*bbc-news*/
  Future<NewsApiResult> getNewsBySourceLang(@Path("q") String searchedData,
      @Path("language") String language, @Path("sources") String sourceId);
}

class NewsDao {
  Dio dio;
  NewsClient client;

  NewsDao() {
    dio = Dio();
    client = NewsClient(dio);
  }

  Future<List<Article>> getNews() {
    return client.getNews().then((value) => value.articles);
  }

  Future<List<Article>> getNewsCatNation({String cat, String country}) {
    if (cat != null && country != null)
      return client
          .getNewsByContCat(country, cat)
          .then((value) => value.articles);
    else if (cat == null && country != null)
      return client.getNewsByCountry(country).then((value) => value.articles);
    else if (cat != null && country == null)
      return client.getNewsByCategory(cat).then((value) => value.articles);
    else
      return client.getNews().then((value) => value.articles);
  }

  Future<List<Article>> getEveryNews(String searchedWord,
      {List<String> sources, String lang}) {
    if (sources != null && lang != null)
      return client
          .getNewsBySourceLang(searchedWord, lang, getSourcesComa(sources))
          .then((value) => value.articles);
    else if (sources == null && lang != null)
      return client
          .getEveryNewsByLang(searchedWord, lang)
          .then((value) => value.articles);
    else if (sources != null && lang == null)
      return client
          .getEveryNewsBySources(searchedWord, getSourcesComa(sources))
          .then((value) => value.articles);
    else if (sources == null && lang == null)
      return client
          .getEveryNews(
            searchedWord,
          )
          .then((value) => value.articles);
    else
      return null;
  }

  Future<List<Article>> getTopNewsBySources(List<String> sources) {
    String sourcesComa = getSourcesComa(sources);
    return client
        .getTopNewsBySources(sourcesComa)
        .then((value) => value.articles);
  }

  Future<List<Article>> getNewsByCountry(String countryId) {
    return client.getNewsByCountry(countryId).then((value) => value.articles);
  }

  Future<List<Article>> getNewsByCategoryLimited(String categoryId) {
    return client
        .getNewsByCategoryLimit(categoryId)
        .then((value) => value.articles);
  }

  getSourcesComa(List<String> sources) {
    String sourcesComa = sources.first;
    sources.forEach((value) {
      if (value != sources[0]) sourcesComa += ",$value";
    });
    print(sourcesComa);
    return sourcesComa;
  }

  Future<List<Source>> getNewsSources() =>
      client.getNewsSources().then((value) => value.sources);

  List<Country> getCountries() => countries;

  List<Tag> getTags() => [
        Tag("Covid"),
        Tag("Trump"),
        Tag("Apple"),
        Tag("Android"),
        Tag("Windows"),
        Tag("Cancer"),
        Tag("Kanye-West"),
        Tag("Terrorist"),
        Tag("Insurgence"),
        Tag("Education"),
        Tag("School"),
      ];
}

@JsonSerializable(explicitToJson: true)
class NewsApiResult {
  String status;
  int totalResults;
  List<Article> articles;

  NewsApiResult({this.status, this.totalResults, this.articles});

  factory NewsApiResult.fromJson(Map<String, dynamic> json) =>
      _$NewsApiResultFromJson(json);

  Map<String, dynamic> toJson() => _$NewsApiResultToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Article {
  Source source;
  String author;
  String title;
  String description;
  String url;
  String urlToImage;
  String publishedAt;
  String content;

  Article(
      {this.source,
      this.author,
      this.title,
      this.description,
      this.url,
      this.urlToImage,
      this.publishedAt,
      this.content});

  factory Article.fromJson(Map<String, dynamic> json) =>
      _$ArticleFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleToJson(this);
}

@JsonSerializable()
class Source {
  String id;
  String name;
  @JsonKey(ignore: true)
  bool selected = false;

  Source(this.id, this.name);

  factory Source.fromJson(Map<String, dynamic> json) => _$SourceFromJson(json);

  Map<String, dynamic> toJson() => _$SourceToJson(this);

  @override
  String toString() {
    // TODO: implement toString
    return name;
  }
}

@JsonSerializable(explicitToJson: true)
class SourcesResult {
  String status;
  List<Source> sources;

  SourcesResult({this.status, this.sources});

  factory SourcesResult.fromJson(Map<String, dynamic> json) =>
      _$SourcesResultFromJson(json);

  Map<String, dynamic> toJson() => _$SourcesResultToJson(this);
}

class Country {
  String id;
  String name;
  bool selected;

  Country({this.id, String name, String selected}) {
    this.selected = selected == null ? false : selected;
    this.name =
        name == null ? CountryCode.parse(id.toUpperCase()).alpha3 : name;
  }
}

class Tag {
  String id;
  String name;
  bool selected = false;

  Tag(this.name, {this.id, this.selected});
}
List<Country> get countries => [
//      Country(id: "ae"),
//      Country(id: "ar"),
//      Country(id: "at"),
      Country(id: "au"),
//      Country(id: "be"),
//      Country(id: "bg"),
//      Country(id: "br"),
//      Country(id: "ca"),
      Country(id: "ch"),
//      Country(id: "cn"),
//      Country(id: "co"),
//      Country(id: "cu"),
//      Country(id: "cz"),
//      Country(id: "de"),
//      Country(id: "eg"),
      Country(id: "fr"),
//      Country(id: "gb"),
      Country(id: "gr"),
//      Country(id: "hk"),
      Country(id: "sa"),
      Country(id: "hu"),
      Country(id: "id"),
      Country(id: "ie"),
//      Country(id: "il"),
//      Country(id: "in"),
//      Country(id: "it"),
//      Country(id: "jp"),
//      Country(id: "kr"),
//      Country(id: "lt"),
//      Country(id: "lv"),
//      Country(id: "ma"),
//      Country(id: "mx"),
      Country(id: "my"),
      Country(id: "ng"),
//      Country(id: "nl"),
//      Country(id: "no"),
//      Country(id: "nz"),
//      Country(id: "ph"),
//      Country(id: "pl"),
//      Country(id: "pt"),
//      Country(id: "ro"),
//      Country(id: "rs"),
//      Country(id: "ru"),
//      Country(id: "sa"),
//      Country(id: "se"),
//      Country(id: "sg"),
//      Country(id: "si"),
//      Country(id: "sk"),
//      Country(id: "th"),
//      Country(id: "tr"),
//      Country(id: "tw"),
      Country(id: "ua"),
      Country(id: "us"),
//      Country(id: "ve"),
//      Country(id: "za"),
    ];

String rubishText=
"kjfdskjfkjdshgkjhdfskjghhjdfkjgkjdfdgkjdsgkjsdjkgd"
"kjfdskjfkjdshgkjhdfskjghhjdfkjgkjdfdgkjdsgkjsdjkgd"
"kjfdskjfkjdshgkjhdfskjghhjdfkjgkjdfdgkjdsgkjsdjkgd"
"kjfdskjfkjdshgkjhdfskjghhjdfkjgkjdfdgkjdsgkjsdjkgd"
"kjfdskjfkjdshgkjhdfskjghhjdfkjgkjdfdgkjdsgkjsdjkgd"
"kjfdskjfkjdshgkjhdfskjghhjdfkjgkjdfdgkjdsgkjsdjkgd"
"kjfdskjfkjdshgkjhdfskjghhjdfkjgkjdfdgkjdsgkjsdjkgd"
"kjfdskjfkjdshgkjhdfskjghhjdfkjgkjdfdgkjdsgkjsdjkgd"
"kjfdskjfkjdshgkjhdfskjghhjdfkjgkjdfdgkjdsgkjsdjkgd"
"kjfdskjfkjdshgkjhdfskjghhjdfkjgkjdfdgkjdsgkjsdjkgd"
"kjfdskjfkjdshgkjhdfskjghhjdfkjgkjdfdgkjdsgkjsdjkgd"
"kjfdskjfkjdshgkjhdfskjghhjdfkjgkjdfdgkjdsgkjsdjkgd"
"kjfdskjfkjdshgkjhdfskjghhjdfkjgkjdfdgkjdsgkjsdjkgd"
"kjfdskjfkjdshgkjhdfskjghhjdfkjgkjdfdgkjdsgkjsdjkgd"
"kjfdskjfkjdshgkjhdfskjghhjdfkjgkjdfdgkjdsgkjsdjkgd"
"kjfdskjfkjdshgkjhdfskjghhjdfkjgkjdfdgkjdsgkjsdjkgd"
"kjfdskjfkjdshgkjhdfskjghhjdfkjgkjdfdgkjdsgkjsdjkgd"
"kjfdskjfkjdshgkjhdfskjghhjdfkjgkjdfdgkjdsgkjsdjkgd"
"kjfdskjfkjdshgkjhdfskjghhjdfkjgkjdfdgkjdsgkjsdjkgd"
"kjfdskjfkjdshgkjhdfskjghhjdfkjgkjdfdgkjdsgkjsdjkgd"
"kjfdskjfkjdshgkjhdfskjghhjdfkjgkjdfdgkjdsgkjsdjkgd"
"kjfdskjfkjdshgkjhdfskjghhjdfkjgkjdfdgkjdsgkjsdjkgd"
"kjfdskjfkjdshgkjhdfskjghhjdfkjgkjdfdgkjdsgkjsdjkgd"
"kjfdskjfkjdshgkjhdfskjghhjdfkjgkjdfdgkjdsgkjsdjkgd"
"kjfdskjfkjdshgkjhdfskjghhjdfkjgkjdfdgkjdsgkjsdjkgd"
"kjfdskjfkjdshgkjhdfskjghhjdfkjgkjdfdgkjdsgkjsdjkgd"
"";