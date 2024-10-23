import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../utils/enum.dart';
import '../../../utils/global.dart';
import '../../widgets/custom_game_button.dart';

class GamePrivacyPolicyScreen extends StatefulWidget {
  const GamePrivacyPolicyScreen({super.key});

  @override
  State<GamePrivacyPolicyScreen> createState() =>
      _GamePrivacyPolicyScreenState();
}

class _GamePrivacyPolicyScreenState extends State<GamePrivacyPolicyScreen> {
  late WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadHtmlString(Global.language == Language.vi.name
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
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(10.w),
              child: Row(
                children: [
                  CustomGameButton(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    height: 35.w,
                    width: 35.w,
                    icon: Icons.arrow_back,
                    iconColor: Colors.white,
                  ),
                ],
              ),
            ),
            Expanded(
              child: WebViewWidget(
                controller: controller,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
