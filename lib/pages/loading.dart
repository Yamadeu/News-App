import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:news/pages/articles_api_class.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';



class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  void getArticlesData(String country, String category, String searchKey) async {

    final Random random = Random();

    List selectedItems = [];
    List selectedItemsCarousel = [];

    ArticleApi instance = ArticleApi(category: category, country: country ,searchKey: searchKey, articlesCarousel : [],articles: []);
    await instance.getData();
    await instance.getDataCarousel();
    List<dynamic> articles = instance.articles;
    List<dynamic> articlesCarousel = instance.articlesCarousel;
    pickRandomElements(category,country,selectedItems,selectedItemsCarousel,articles,random,articlesCarousel,searchKey);
  }

  void pickRandomElements(String category, String country,List selectedItems,List selectedItemsCarousel, List articles, Random random,List articlesCarousel, String searchKey){
    selectedItems.clear();
    for(int i=0; i < articles.length; i++){
      int randIndex = random.nextInt(articles.length);
      int randIndexCarousel = random.nextInt(articles.length);
      selectedItems.add(articles[randIndex]);
      selectedItemsCarousel.add(articlesCarousel[randIndexCarousel]);
    }
    print(country);
    print(selectedItemsCarousel);
    Navigator.pushReplacementNamed(context, "/",arguments: {
      'articles_group': selectedItems,
      "articles_carousel_group" : selectedItemsCarousel,
      "country" : country,
      "category" : category,
      "key" : searchKey
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map<dynamic,dynamic>? country = ModalRoute.of(context)?.settings.arguments as Map<dynamic,dynamic>?;


    getArticlesData(country?['country'] ?? "us", country?['category'] ?? "technology",country?['key'] ?? "");

    return Scaffold(
      backgroundColor: Colors.red[800],
      body: Center(
        child: SpinKitFadingCircle(
          color: Colors.red[100],
          size: 150,
        ),
      ),
    );
  }
}
