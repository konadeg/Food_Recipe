


import 'dart:async';


import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class RecipeView extends StatefulWidget {
 String uri;
 
 RecipeView(this.uri);

  
  @override
  State<RecipeView> createState() => _RecipeViewState();
}

class _RecipeViewState extends State<RecipeView> {
    
  final Completer<WebViewController> controller = Completer<WebViewController>();
  
 
  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      appBar: AppBar(
       backgroundColor:   Color.fromARGB(255, 15, 25, 1),
        title: Text("Food Recipe Webview",
        style: TextStyle(
          
        ),
        
        ),
      ),
      body: Container(
        child: WebView(
          initialUrl:widget.uri,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController WebViewController){
            setState(() {
              controller.complete(WebViewController);
            });
          },

        ),
      ),
    );
  }
}