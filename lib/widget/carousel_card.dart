import 'package:flutter/cupertino.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../pages/webview.dart';

Widget CarouselCard(BuildContext context, List articles, country,category, searchKey){

  List images = [];

  for(int i=0; i < articles.length; i++){
    images.add(articles[i]['urlToImage']);
  }

  return CarouselSlider(
    items: [
      //1st Image of Slider
      for (int index = 0; index < images.length; index++)
        Banner(
          location: BannerLocation.topStart,
          message: 'Top Headlines',
          child: InkWell(
            onTap: (){
              Navigator.pushReplacementNamed(context, "/web", arguments: {
                'title' : articles[index]['title'],
                'url' : articles[index]['url'],
                'country': country,
                "category" : category,
                'key' : searchKey
              });
            },
            child: Stack(
              children: [
                Container(
                  margin: EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      image: NetworkImage(
                        images[index] == null
                            ? "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSW1mqRHkuD5vYG2jM2IrlxRi_T4ryPpoif0P9IGPNwYmQdD9FUibxGPbNUNAU1r1tSjwM&usqp=CAU"
                            : images[index],
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  child: Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                          colors: [
                            Colors.black12.withOpacity(0),
                            Colors.black
                          ],
                          begin: Alignment.topCenter,
                          end : Alignment.bottomCenter,
                        )
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          articles[index]['title'] == null ? "No title available for this article" :articles[index]['title'],
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                        ),
                      ),
                    )
                  ),
                )
              ],
            ),
          ),
        ),

    ],
    options: CarouselOptions(
      height: 200.0,
      enlargeCenterPage: true,
      autoPlay: true,
      aspectRatio: 16 / 9,
      autoPlayCurve: Curves.fastOutSlowIn,
      enableInfiniteScroll: true,
      autoPlayAnimationDuration: Duration(milliseconds: 800),
      viewportFraction: 0.8,
    ),
  );
}