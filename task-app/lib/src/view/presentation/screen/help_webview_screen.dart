import 'package:flutter/material.dart';
import 'package:taskapp/src/core/colors.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HelpWebviewScreen extends StatefulWidget {
  const HelpWebviewScreen({super.key});

  @override
  State<HelpWebviewScreen> createState() => _HelpWebviewScreenState();
}

class _HelpWebviewScreenState extends State<HelpWebviewScreen> {
 
 
 WebViewController controller = WebViewController()
  ..setJavaScriptMode(JavaScriptMode.unrestricted)
  ..setBackgroundColor(const Color(0x00000000))
  ..setNavigationDelegate(
    NavigationDelegate(
      onProgress: (int progress) { },
      onPageStarted: (String url) {},
      onPageFinished: (String url) {},
      onWebResourceError: (WebResourceError error) {},
      onNavigationRequest: (NavigationRequest request) => NavigationDecision.navigate
    ),
  )
  ..loadRequest(Uri.parse('https://github.com/M8mamad2'));

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(icon: const Icon(Icons.arrow_back,color: kThiredColor,), onPressed: (){},),
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}