import 'package:flutter/material.dart';
import 'package:hassan_beh/shared/components/components.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewer extends StatelessWidget {
  const WebViewer({Key? key,required this.url,}) : super(key: key);

  final String url ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DETAILS'),
        actions: [
          defaultThemChangerIcon(context: context),
        ],
      ),
      body:WebView(
        initialUrl: url,
      ),
    );
  }
}
