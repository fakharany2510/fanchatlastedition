import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyPolicies extends StatefulWidget {
  const PrivacyPolicies({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicies> createState() => _PrivacyPoliciesState();
}

class _PrivacyPoliciesState extends State<PrivacyPolicies> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebView(
        initialUrl: 'https://github.com/mohamed-halemo/FanChat-Privacy/blob/main/privacy-policy.md',
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
