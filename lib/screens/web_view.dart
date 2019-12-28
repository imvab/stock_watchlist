//import 'package:flutter/foundation.dart';
import 'dart:async';

import 'package:flutter/material.dart';
//import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebPageView extends StatefulWidget {
  final String stockName;

  //WebPage({Key key, this.stockName}) : super(key: key);
  WebPageView({this.stockName});
  @override
  _WebPageViewState createState() => _WebPageViewState();
}

class _WebPageViewState extends State<WebPageView> {
  //Completer<WebViewController> _controler = Completer<WebViewController>();

  //Factory<ZoomPageTransitionsBuilder> zoom = Factory<ZoomPageTransitionsBuilder>(() => ZoomPageTransitionsBuilder());
  //var gestureSet = Set.from([Factory<ZoomPageTransitionsBuilder>(() => ZoomPageTransitionsBuilder())]); 
  @override
  Widget build(BuildContext context) {
    /*
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.stockName)
      ),
      body: Builder(
        builder: (context) {
          return WebView(
            initialUrl: "https://in.tradingview.com/chart/?symbol=NSE%3A" + widget.stockName,
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController){
              _controler.complete(webViewController);
            },
          );
        }
      )
    );
  }
  */
  
    return WebviewScaffold(
      url: "https://in.tradingview.com/chart/?symbol=NSE%3A" + widget.stockName,
      withJavascript: true,
      withZoom: true,
      appBar: AppBar(
        title: Text("${widget.stockName}"),
        backgroundColor: Colors.black,
      ),
    );
  }
}