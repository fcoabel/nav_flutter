import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


void main() {
  runApp(Navegador());
}

class Navegador extends StatefulWidget{
  const Navegador({Key? key}) : super(key: key);
  _Navegador createState() => _Navegador();
}

class _Navegador extends State<Navegador> {
  late WebViewController _webViewController;
  final String homepage = "https://www.google.com";
  final TextEditingController toSearch = TextEditingController();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'browserFlutter',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[900],
          elevation: 0,
          title: TextField(
            controller: toSearch,
            cursorColor: Colors.red,
            style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Buscar',
                hintStyle: TextStyle(color: Colors.white)
              ),
          ),
          actions: <Widget>[
            IconButton(
              onPressed: (){
                setState(() {
                  _webViewController.goBack();
                });
              }, 
              icon: Icon(Icons.arrow_back_sharp)
            ),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: (){setState(() {
                _search(toSearch.text);
              });},
            ),
            IconButton(
              icon: Icon(Icons.forward),
              onPressed: () {
                setState(() {
                  _webViewController.goForward();
                });
              },
            )
          ],
        ),
        body: WebView(
           initialUrl: homepage,
           javascriptMode: JavascriptMode.unrestricted,
           onWebViewCreated: (WebViewController) {
             _webViewController = WebViewController;
           },
        ), 
      )
    );
  }

  void _search(String url){
    if(!url.startsWith("https://")){
      url = "https://" + url;
    }
    if(_webViewController != null){
      _webViewController.loadUrl(url) ;
    }
  }
}