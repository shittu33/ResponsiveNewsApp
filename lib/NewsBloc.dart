import 'dart:async';
import 'news.dart';

class NewsRepository {
  final newsDao = NewsDao();

//  Future<Article> addStudent(Article news) => newsDao.addStudent(news);

  Future<List<Article>> getNews() => newsDao.getNews();

  Future<List<Article>> getNewsByCountry(String countryId) =>
      newsDao.getNewsByCountry(countryId);

  Future<List<Article>> getNewsByCategoryLimited(String categoryId) =>
      newsDao.getNewsByCategoryLimited(categoryId);

  Future<List<Source>> getNewsSources() => newsDao.getNewsSources();

  List<Country> getCountries() => newsDao.getCountries();

  List<Tag> getTags() => newsDao.getTags();

//  Future<Student> getStudent(String id) => newsDao.getStudent(id);

//  Future<void> deleteStudent(String id) => newsDao.deleteStudent(id);

//  Future<Student> updateStudent(Student student) =>
//      newsDao.updateStudent(student);
}

class NewsBloc {
  final newsRepo = NewsRepository();
  final newsController = StreamController<List<Article>>.broadcast();

  get news => newsController.stream;

  NewsBloc() {
    getNews();
  }

  dispose() {
    newsController.close();
  }

//  addStudent(Student student) async {
//    await newsRepo.addStudent(student);
//    getNews();
//  }

  getNews() async {
    newsController.sink.add(await newsRepo.getNews());
  }

  getNewsByCountry(String countryId) async =>
      newsController.sink.add(await newsRepo.getNewsByCountry(countryId));
}

class SourcesBloc {
  final newsRepo = NewsRepository();
  final controller = StreamController<List<Source>>.broadcast();

  get sources => controller.stream;

  SourcesBloc() {
    getSources();
  }

  Future<void> getSources() async =>
      controller.sink.add(await newsRepo.getNewsSources());

  dispose() {
    controller.close();
  }
}

class CountryBloc {
  final newsRepo = NewsRepository();
  final controller = StreamController<List<Country>>.broadcast();

  get streamCountries => controller.stream;

  CountryBloc() {
    controller.sink.add(newsRepo.getCountries());
  }

  dispose() {
    controller.close();
  }
}

class TagBloc {
  final newsRepo = NewsRepository();
  final tagController = StreamController<List<Tag>>.broadcast();

  get tags => tagController.stream;

  TagBloc() {
    getTags();
  }

  Future<void> getTags() async => tagController.sink.add(newsRepo.getTags());

  dispose() {
    tagController.close();
  }
}

class LimitCatBloc {
  final newsRepo = NewsRepository();
  final sportCatController = StreamController<List<Article>>.broadcast();
  final bizCatController = StreamController<List<Article>>.broadcast();
  final entCatController = StreamController<List<Article>>.broadcast();
  final healthCatController = StreamController<List<Article>>.broadcast();
  final techCatController = StreamController<List<Article>>.broadcast();
  final sciCatController = StreamController<List<Article>>.broadcast();

  get sportNews => sportCatController.stream;

  Stream<List<Article>> get bizNews => bizCatController.stream;

  get entNews => entCatController.stream;

  get healthNews => healthCatController.stream;

  get techNews => techCatController.stream;

  get sciNews => sciCatController.stream;

  LimitCatBloc() {
    getSportCatLimited();
    getBizCatLimited();
    getEntCatLimited();
    getHealthCatLimited();
    getTechCatLimited();
    getSciCatLimited();
  }

   Future<bool>get isEmpty async {
    return await bizNews.isEmpty.then((value) => null);
  }

  dispose() {
    sportCatController.close();
    bizCatController.close();
    entCatController.close();
    healthCatController.close();
    techCatController.close();
    sciCatController.close();
  }

  getSportCatLimited() async => sportCatController.sink
      .add(await newsRepo.getNewsByCategoryLimited('sports'));

  getBizCatLimited() async => bizCatController.sink
      .add(await newsRepo.getNewsByCategoryLimited('business'));

  getEntCatLimited() async => entCatController.sink
      .add(await newsRepo.getNewsByCategoryLimited('entertainment'));

  getHealthCatLimited() async => healthCatController.sink
      .add(await newsRepo.getNewsByCategoryLimited('health'));

  getTechCatLimited() async => techCatController.sink
      .add(await newsRepo.getNewsByCategoryLimited('technology'));

  getSciCatLimited() async => sciCatController.sink
      .add(await newsRepo.getNewsByCategoryLimited('science'));
}
