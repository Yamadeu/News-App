import 'package:flutter/material.dart';


Widget ArticleCard(BuildContext context, List articles,int index, country,category, searchKey){
  return InkWell(
    onTap: () {
      Navigator.pushReplacementNamed(context, "/web", arguments: {
        'title' : articles[index]['title'],
        'url' : articles[index]['url'],
        'country': country,
        "category" : category,
        "key": searchKey
      });
    },
    child: Card(
      margin: EdgeInsets.all(10),
      color: Colors.white,
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20)
            ),
            child: Image.network(
              articles[index]['urlToImage'] == null ? "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSW1mqRHkuD5vYG2jM2IrlxRi_T4ryPpoif0P9IGPNwYmQdD9FUibxGPbNUNAU1r1tSjwM&usqp=CAU" :articles[index]['urlToImage'],
              fit: BoxFit.cover,
              width: double.infinity,
              height: 200,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment:  CrossAxisAlignment.start,
              children: [
                SizedBox(height: 15,),
                Text(articles[index]['title'] == null ? "No title available for this article" : articles[index]['title'],
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                SizedBox(height: 10,),
                Text(articles[index]['description'] == null ? "No description available for this article" : articles[index]['description'],
                    style: TextStyle(color: Colors.grey[500], fontSize: 17),
                  maxLines: 4,
                ),
              ],
            ),
          ),

        ],
      ),
    ),
  );
}