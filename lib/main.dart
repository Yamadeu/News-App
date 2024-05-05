import 'package:flutter/material.dart';
import 'package:news/pages/home.dart';
import 'package:news/pages/loading.dart';
import 'package:news/pages/webview.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: "/loading",
    routes : {
      '/': (context) => Home(),
      '/loading' : (context) => Loading(),
      '/web' : (context) => WebViewNews(),
    }
  )
  );
}
