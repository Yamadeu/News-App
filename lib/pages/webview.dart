import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewNews extends StatefulWidget {
  WebViewNews({Key? key,}) : super(key: key);

  @override
  State<WebViewNews> createState() => _WebViewNewsState();
}

class _WebViewNewsState extends State<WebViewNews> {


  final Completer<WebViewController> controller =
  Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {

    Map<dynamic,dynamic>? arguments = ModalRoute.of(context)?.settings.arguments as Map<dynamic,dynamic>;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[800],
        title: Text(arguments['title'] ?? "Flash News",style: TextStyle(letterSpacing: 2.0, fontFamily: "Lobster_Regular", color: Colors.white),),
        centerTitle: true,
        leading: IconButton(
          onPressed: (){
            Navigator.pushReplacementNamed(context, "/loading", arguments: {
              'country' : arguments['country'],
              'category' : arguments['category'],
              'key': arguments['key']
            });
            },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
        body: WebView(
          initialUrl: arguments['url'] ?? "https://flutter.dev",
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            setState(() {
              controller.complete(webViewController);
            });
          },
        ));
  }
}