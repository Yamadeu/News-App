import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:news/api_key.dart';



class ArticleApi {

  String country;
  String category;
  List articles,articlesCarousel;
  String searchKey;

  ArticleApi({required this.category,required this.country, required this.articles,required this.articlesCarousel, required this.searchKey});

  Future<void> getData () async {
     // TODO: Verify if the pageSize works well
    String baseUrl = "https://newsapi.org/v2/top-headlines?country=$country&q=$searchKey&pageSize=100&category=$category&apiKey=$apiKey";

    try{
      Uri url = Uri.parse(baseUrl);
      Response response = await http.get(url);
      dynamic body = jsonDecode(response.body);
      articles = body["articles"];
      print(articles);
    }catch(e){
      print("Error : $e");
      articles = [];
    }
  }

  Future<void> getDataCarousel () async {
    
    // TODO: Verify if the pageSize works well
    String baseUrl = "https://newsapi.org/v2/top-headlines?country=$country&q=$searchKey&pageSize=100&category=$category&apiKey=$apiKey";

    try{
      Uri url = Uri.parse(baseUrl);
      Response response = await http.get(url);
      dynamic body = jsonDecode(response.body);
      articlesCarousel = body["articles"];
    }catch(e){
      print("Error : $e");
      articlesCarousel = [];
    }
  }



}
