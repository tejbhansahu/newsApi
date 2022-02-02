import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:newsapi/api/API.dart';
import 'package:newsapi/model/model_news.dart';

abstract class HomeProvider extends ChangeNotifier {
  Future<void> fetchNews(
      {bool isFiltering = false, String? sources, String? searchQuery});

  updateLocation({required Map<String, String> country});

  addSources({required Map<String, bool> source});

  resetSources();

  clearArticles();

  changeFilter({required String filter});

  List<String> get timeFilters;

  String get defaultFilter;

  List<Article> get articles;

  Map<String, String> get allCountries;

  Map<String, String> get selectedCountry;

  Map<String, bool> get allSources;

  bool isArticlesLoading = false;
}

class HomeData extends ChangeNotifier implements HomeProvider {
  final Dio _dio = Dio();

  int _page = 1;

  List<String> _timeFilters = ['Newest', 'Oldest'];

  List<String> get timeFilters => _timeFilters;

  String _defaultFilter = 'Newest';

  @override
  String get defaultFilter => _defaultFilter;

  @override
  changeFilter({required String filter}) {
    _defaultFilter = filter;
    if (filter.contains('Oldest'))
      articles.sort((a, b) => a.publishedAt!.compareTo(b.publishedAt!));
    else
      articles.sort((a, b) => b.publishedAt!.compareTo(a.publishedAt!));
    notifyListeners();
  }

  Map<String, String> _selectedCountry = {"USA": "us"};

  Map<String, String> get selectedCountry => _selectedCountry;

  Map<String, String> _allCountries = {
    "USA": "us",
    "India": "in",
    "Singapore": "sg",
    "Sweden": "se",
    "Australia": "au",
    "China": "cn",
    "Japan": "jp"
  };

  @override
  Map<String, String> get allCountries => _allCountries;

  Map<String, bool> _allSources = {
    "bbc-news": false,
    "techcrunch": false,
    "cnn": false,
    "abc-news": false,
    "google-news": false,
    "buzzfeed": false,
  };

  @override
  Map<String, bool> get allSources => _allSources;

  @override
  resetSources() {
    allSources.updateAll((key, value) => false);
    notifyListeners();
  }

  @override
  clearArticles() {
   _article.clear();
  }

  @override
  addSources({required Map<String, bool> source}) {
    _allSources[source.keys.first] = source.entries.first.value;
    notifyListeners();
  }

  List<Article> _article = <Article>[];

  @override
  List<Article> get articles => _article;

  set articles(List<Article> articles) {
    _article = articles;
  }

  void addArticlesToList(List<Article> articleData, String? query) {
    _article.addAll(articleData);
    isArticlesLoading = false;
    notifyListeners();
  }

  @override
  bool isArticlesLoading = false;

  @override
  updateLocation({required Map<String, String> country}) {
    selectedCountry.clear();
    selectedCountry.addAll(country);
    notifyListeners();
  }

  @override
  Future<void> fetchNews(
      {bool isFiltering = false, String? sources, String? searchQuery}) async {
    try {
      isArticlesLoading = true;
      notifyListeners();
      var response = await _dio.get(searchQuery == null
          ? API.newsApi(
              country:
                  isFiltering ? '' : selectedCountry.entries.elementAt(0).value,
              source: sources ?? '', page: _page)
          : API.searchApi(query: searchQuery, page: _page));
      print(response.data);
      if (response.statusCode == 200) {
        _page = _page + 1;
        print("Page length is: $_page");
        addArticlesToList(News.fromJson(response.data).articles, searchQuery);
      }
    } on DioError catch (e) {
      if (kDebugMode) {
        print('Error response: ${e.response}');
      }
      rethrow;
    } finally {
      if (isArticlesLoading) {
        isArticlesLoading = false;
        notifyListeners();
      }
    }
  }
}
