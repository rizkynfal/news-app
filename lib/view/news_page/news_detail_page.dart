import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:news_app/global.dart' as global;
import 'package:webview_flutter/webview_flutter.dart';
// Import for Android features.
import 'package:webview_flutter_android/webview_flutter_android.dart';
// Import for iOS features.
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

// #enddocregion platform_imports
class ArticleDetails extends StatefulWidget {
  const ArticleDetails({super.key, required this.articleURL});
  final String articleURL;

  @override
  State<ArticleDetails> createState() => _ArticleDetailsState();
}

class _ArticleDetailsState extends State<ArticleDetails> {
  var loadingPercentage = 0;
  late WebViewController? webViewController;
  late String url = widget.articleURL;
  @override
  void initState() {
    super.initState();
    late final PlatformWebViewControllerCreationParams params;

    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(params);

    if (WebViewPlatform.instance is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (WebViewPlatform.instance as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }
    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (progress) {
            setState(() {
              loadingPercentage = progress;
            });
          },
          onPageStarted: (url) {
            setState(() {
              loadingPercentage = 0;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              loadingPercentage = 100;
            });
          },
        ),
      )
      ..loadRequest(Uri.parse(url));

    // #docregion platform_features
    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }
    // #enddocregion platform_features

    webViewController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        actions: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  width: 80,
                ),
                const Text(
                  "Article Detail",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                CountryCodePicker(
                  flagDecoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.white,
                          width: 1,
                          strokeAlign: BorderSide.strokeAlignOutside),
                      borderRadius: BorderRadius.circular(20)),
                  onChanged: (element) => {
                    setState(() {
                      global.country = element.code.toString().toLowerCase();
                    })
                  },
                  initialSelection: global.country,
                  hideMainText: true,
                  showCountryOnly: true,
                  showOnlyCountryWhenClosed: true,
                ),
              ],
            ),
          ),
        ],
        backgroundColor: const Color(0xFF1F4690),
      ),
      body: Stack(
        children: [
          WebViewWidget(
            controller: webViewController!,
          ),
          if (loadingPercentage < 100)
            LinearProgressIndicator(
              value: loadingPercentage / 100.0,
            ),
        ],
      ),
    );
  }
}
