import 'package:dio/dio.dart';

import '../model/article_model.dart';

const String News_API_KEY = '45efd51cc5304e139b8012d4a8fedad2';
const String BASE_URL = 'https://newsapi.org/v2';
// $BASE_URL/everything?q=everything&apiKey=$News_API_KEY

class NewsServices {
  final dio = Dio();

  Future<List<ArticleModel>> getNews() async {
    try {
      Response response = await dio.get(
          'https://newsdata.io/api/1/latest?country=eg&category=top&apikey=pub_62295464dfce3bd64be595d2b4f1221f36696');
      Map<String, dynamic> jsonData = response.data;
      List<dynamic> articles = jsonData['results'];
      List<ArticleModel> articlesList = [];

      for (var article in articles) {
        ArticleModel articleModel = ArticleModel.fromJson(article);
        articlesList.add(articleModel);
      }
      return articlesList;
    } catch (e) {
      return [];
    }
  }

  Future<List<ArticleModel>> searchNews({required String value}) async {
    try {
      Response response = await dio.get(
          'https://newsdata.io/api/1/latest?country=eg&category=top&apikey=pub_62295464dfce3bd64be595d2b4f1221f36696');
      Map<String, dynamic> jsonData = response.data;

      List<dynamic> articles = jsonData['results'];
      List<ArticleModel> articlesList = [];

      for (var data in articles) {
        ArticleModel articleModel = ArticleModel.fromJson(data);
        articlesList.add(articleModel);
      }
      return articlesList;
    } catch (e) {
      return [];
    }
  }
}
