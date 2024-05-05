import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/painting.dart';
import 'package:news/widget/article_card.dart';
import 'package:news/widget/carousel_card.dart';
import 'package:news/pages/articles_api_class.dart';
import 'package:news/model/countries.dart';
import 'package:news/model/categories.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {


 // Scaffold global key to pop the drawer menu
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {

    // data recieved from loading page
    Map<dynamic, dynamic>? articles = ModalRoute.of(context)?.settings.arguments as Map<dynamic, dynamic>?;

    TextEditingController _searchKey = TextEditingController(text: articles?['key']);

    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      key: _scaffoldKey,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
                decoration: BoxDecoration(
                    color: Colors.red[800]
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage("assets/egypt.png"),
                      radius: 40,
                    ),
                    SizedBox(height: 15,),
                    Text(
                        articles?['country'] == "us"
                            ? "Flash News: USA":
                        articles?['country'] == "ca"
                            ?"Flash News: CANADA" :
                        articles?['country'] == "za"
                            ?"Flash News: SOUTH AFRICA" :
                        articles?['country'] == "cn"
                            ?"Flash News: CHINA" :
                        articles?['country'] == "de"
                            ?"Flash News: GERMANY" :
                        articles?['country'] == "in"
                            ? "Flash News: INDIA" :
                        articles?['country'] == "fr"
                            ? "Flash News: FRANCE" : "News Flash: USA",
                        style : TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    Text("Category : ${articles?['category'] ?? "Technology"}",
                        style : TextStyle(color: Colors.white,fontSize: 15, fontWeight: FontWeight.w400)
                    )
                  ],
                )
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20),
              child: Text("Countries", style: TextStyle(fontSize: 15, color: Colors.grey, fontWeight: FontWeight.bold)),
            ),
            Divider(height: 20,),

            for(int i=0; i < coutries_names.length; i++)
              ListTile(
                onTap: (){
                  ArticleApi instance = ArticleApi(searchKey: articles?['key'],category: articles?['category'] ?? "technology",country: coutries_names[i]['abbreviation'],articlesCarousel : [],articles: []);
                  Navigator.pushReplacementNamed(context, "/loading", arguments: {
                    "country" : instance.country,
                    'category' : instance.category,
                    "key" : instance.searchKey
                  });
                },
                leading: Icon(Icons.arrow_circle_right),
                title: Text(coutries_names[i]['country_name']),

              ),

            Divider(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20),
              child: Text("Categories", style: TextStyle(fontSize: 15, color: Colors.grey, fontWeight: FontWeight.bold)),
            ),
            Divider(height: 20,),

            for(int i=0; i < categories_names.length; i++)
              ListTile(
              onTap: (){
                ArticleApi instance = ArticleApi(searchKey: articles?['key'],category: categories_names[i]["category_parameter"], country: coutries_names[i]['abbreviation'],articlesCarousel : [],articles: []);
                Navigator.pushReplacementNamed(context, "/loading", arguments: {
                  "country" : instance.country,
                  'category' : instance.category,
                  "key" : instance.searchKey
                });
              },
              leading: Icon(Icons.arrow_circle_right),
              title: Text(categories_names[i]["category_name"]),

            ),

          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.red[800],
        title: Text("Flash News", style : TextStyle(letterSpacing: 2.0, fontFamily: "Lobster_Regular", color: Colors.white)),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: (){
                Navigator.pushReplacementNamed(context, "/loading", arguments: {
                  'country' : articles?['country'] ?? 'us',
                  'category' : articles?['category'] ?? "technology",
                  'key': articles?['key'] ?? ""
                });
              },
              icon: Icon(Icons.refresh, color: Colors.white)
          )
        ],
        leading: IconButton(
          onPressed: (){
            _scaffoldKey.currentState?.openDrawer();
          },
          icon : Icon(Icons.menu, color: Colors.white)
        )
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10),
              child: TextField(
                controller: _searchKey,
                minLines: 1,
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    contentPadding: EdgeInsets.all(20),
                    fillColor: Colors.white,
                    hintText: "Search News",
                    suffixIcon: IconButton(onPressed: (){
                      if(_searchKey.text.isNotEmpty || _searchKey.text != ""){
                        Navigator.pushReplacementNamed(context, '/loading',arguments: {
                          'country': articles?['country'],
                          "category" : articles?['category'],
                          'key' : _searchKey.text
                        });
                      }else{
                        // nothing happens
                        setState(() {
                          Navigator.pushReplacementNamed(context, '/loading',arguments: {
                            'country': articles?['country'],
                            "category" : articles?['category'],
                            'key' : ""
                          });
                        });
                      }
                    },icon: Icon(Icons.search),)
                ),
              ),
            ),
            CarouselCard(context, articles?["articles_carousel_group"] ?? [],articles?['country'] ?? 'us',articles?['category'] ?? 'technology',articles?['key'] ?? ""),
            SizedBox(height: 10,),
            ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: articles?["articles_group"].length,
                itemBuilder: (context, index){
                  return ArticleCard(context, articles?["articles_group"],index,articles?['country'] ?? 'us',articles?['category'] ?? 'technology', articles?['key'] ?? "");
                }
            ),
          ],
        ),
      )

    );
  }
}
