import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white);

    _limparCacheECarregar();
  }

  Future<void> _limparCacheECarregar() async {
    await _controller.clearCache(); // Limpa o cache apenas ao iniciar
    _controller
        .loadRequest(Uri.parse('https://flyer-admin-ui.flutterflow.app/'));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: WebViewWidget(controller: _controller),
      ),
    );
  }
}
