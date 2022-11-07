import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Eula extends StatefulWidget {
  const Eula({Key? key}) : super(key: key);

  @override
  State<Eula> createState() => _EulaState();
}

class _EulaState extends State<Eula> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebView(
        initialUrl: 'https://webbingstone.org/privacy/fanchattapp/eula.html',
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
