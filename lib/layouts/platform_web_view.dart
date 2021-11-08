import 'dart:io';

import 'package:crypto_currancy/state_management/model/financePlatform.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PlatformWebView extends StatefulWidget {
  final FinancePlatform financePlatform;

  const PlatformWebView({
    Key? key,
    required this.financePlatform,
  }) : super(key: key);

  @override
  _PlatformWebViewState createState() => _PlatformWebViewState();
}

class _PlatformWebViewState extends State<PlatformWebView> {
  bool loading = true;
  late WebViewController controller;

  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (await controller.canGoBack()) {
          controller.goBack();
          return false;
        } else {
          return true;
        }
        // return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.financePlatform.name,
            style: Theme.of(context).textTheme.headline5,
          ),
          centerTitle: true,
          leadingWidth: 100,
          actions: [
            IconButton(
              onPressed: () async {
                if (await controller.canGoForward()) {
                  controller.goForward();
                }
              },
              icon: Icon(Icons.arrow_forward_outlined),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  loading = true;
                });
                controller.reload();
              },
              icon: Icon(Icons.refresh),
            ),
          ],
          leading: Row(children: [
            IconButton(
              onPressed: () async {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.close),
            ),
            IconButton(
              onPressed: () async {
                if (await controller.canGoBack()) {
                  controller.goBack();
                } else {
                  Navigator.of(context).pop();
                }
              },
              icon: Icon(Icons.arrow_back_outlined),
            ),
          ]),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (loading) LinearProgressIndicator(),
            Expanded(
              child: WebView(
                initialUrl: widget.financePlatform.website_url,
                javascriptMode: JavascriptMode.unrestricted,
                // gestureNavigationEnabled: true,
                allowsInlineMediaPlayback: true,
                onProgress: (p) {
                  if (p == 100) {
                    setState(() {
                      loading = false;
                    });
                  }
                },
                onWebViewCreated: (c) {
                  controller = c;
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
