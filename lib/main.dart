import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:file_picker/file_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  const String appUrl = String.fromEnvironment("APP_URL");

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
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint("Carregando: $progress%");
          },
          onPageStarted: (String url) {
            debugPrint('Página iniciada: $url');
          },
          onPageFinished: (String url) {
            debugPrint('Página carregada: $url');
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint("Erro: \${error.description}");
          },
        ),
      );
    
    _habilitarUploads();
    _limparCacheECarregar();
  }

  Future<void> _limparCacheECarregar() async {
    await _controller.clearCache();
    _controller.loadRequest(Uri.parse(appUrl));
  }

  Future<void> _habilitarUploads() async {
  	if (_controller.platform is WebViewAndroidController) {
    	final androidController = _controller.platform as WebViewAndroidController;
	
    	await androidController.setOnShowFileSelector((params) async {
	
      	final result = await FilePicker.platform.pickFiles();
      	
      	if (result != null && result.files.isNotEmpty) {
        	final filePath = result.files.single.path;
        	return [filePath!];
      	}
	
      	return null;
    	});
  	}
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
		body: SafeArea(
  		child: WebViewWidget(controller: _controller),
		),
      ),
    );
  }
}
