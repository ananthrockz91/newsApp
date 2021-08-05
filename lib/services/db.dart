import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:test_app/models/news.dart';

class DataService {

  String url = "https://api.first.org/data/v1/news";

 List<NewsModel> listOfNewsModel = [];


 Future<List<NewsModel>> getNews() async{

  try{

    final response = await http.get(Uri.parse(url));

    if(response.statusCode == 200) {

      var jsonData = jsonDecode(response.body);

      for(var news in jsonData["data"]){
        NewsModel newsModel = NewsModel.fromJson(news);
        listOfNewsModel.add(newsModel);
      }
      print(listOfNewsModel.length);

    } else {
      // add something to inform user about the issue
    }

  } catch(e) {
    return listOfNewsModel;
  }
  return listOfNewsModel;
}

}