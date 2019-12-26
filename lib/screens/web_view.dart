import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
//import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebPage extends StatefulWidget {
  final String value;

  WebPage({Key key, this.value}) : super(key: key);

  @override
  _WebPageState createState() => _WebPageState();
}

class _WebPageState extends State<WebPage> {
  //Completer<WebViewController> _controler = Completer<WebViewController>();

  //Factory<ZoomPageTransitionsBuilder> zoom = Factory<ZoomPageTransitionsBuilder>(() => ZoomPageTransitionsBuilder());
  //var gestureSet = Set.from([Factory<ZoomPageTransitionsBuilder>(() => ZoomPageTransitionsBuilder())]); 
  @override
  Widget build(BuildContext context) {
    /*
    return Scaffold(
      appBar: new AppBar(
        title: new Text("${widget.value}"),
      ),
      body: WebView(
        initialUrl: "https://in.tradingview.com/chart/?symbol=NSE%3A" + widget.value,
        //initialUrl: "https://google.com",
        javascriptMode: JavascriptMode.unrestricted,
        //gestureRecognizers: gestureSet,
        onWebViewCreated: (WebViewController webViewController){
          _controler.complete(webViewController);
        },
      ) 
    );
  }
  */
    return WebviewScaffold(
      url: "https://in.tradingview.com/chart/?symbol=NSE%3A" + widget.value,
      withJavascript: true,
      withZoom: true,
      appBar: AppBar(
        title: Text("${widget.value}"),
      ),
    );
  }
}