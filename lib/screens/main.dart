import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  String url = 'http://192.168.0.145:3000/';
  Set<JavascriptChannel>? channel;
  WebViewController? controller;

  @override
  Widget build(BuildContext context) {

    return WebView(
      initialUrl: url,
      onWebViewCreated: (controller) {
        this.controller = controller;
      },
      javascriptChannels: channel,
      javascriptMode: JavascriptMode.unrestricted,
    );
  }
}