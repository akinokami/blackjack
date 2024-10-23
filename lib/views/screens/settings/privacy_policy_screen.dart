import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../utils/enum.dart';
import '../../../utils/global.dart';
import '../../widgets/custom_text.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  late WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadHtmlString(Global.language == Language.zh.name
          ? Global.policyZh
          : Global.language == Language.vi.name
              ? Global.policyVi
              : Global.language == Language.ko.name
                  ? Global.policyKo
                  : Global.language == Language.hi.name
                      ? Global.policyHi
                      : Global.policyEn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        title: CustomText(
          text: '',
          fontSize: 15.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}
