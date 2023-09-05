import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:store_redirect/store_redirect.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:wowondertimelineflutterapp/String.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:wowondertimelineflutterapp/Util/TextUtil.dart';
import 'package:wowondertimelineflutterapp/Widget/ScaffoldWidget.dart';
import 'package:wowondertimelineflutterapp/main.dart';

import '../../Images.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  final _dialog = RatingDialog(
    initialRating: 1.0,
    // your app's name?
    title: Text(
      'Rating Dialog'.tr,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
    ),
    // encourage your user to leave a high rating?
    message: Text(
      'Tap a star to set your rating. Add more description here if you want.'
          .tr,
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 15),
    ),
    // your app's logo?
    image: Image.asset(
      'assets/icon.png',
      height: 100,
      width: 100,
    ),
    submitButtonText: 'Submit'.tr,
    commentHint: 'Set your custom comment hint'.tr,
    onCancelled: () => print('cancelled'),
    onSubmitted: (response) {
      print('rating: ${response.rating}, comment: ${response.comment}');

      // TODO: add your own logic
      if (response.rating < 3.0) {
        // send their comments to your email or anywhere you wish
        // ask the user to contact you instead of leaving a bad review
      } else {
        StoreRedirect.redirect(androidAppId: PackageAndroid, iOSAppId: IOSid);
      }
    },
  );

  // show the dialog

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      AppBarTrueOrFalse: true,
      centerTitle: false,
      elevation: 1,
      loding: false,
      title: 'Help & Support'.tr,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Support'.tr,
                style: SafeGoogleFont(Fonts.font3,
                    fontSize: 19, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
                decoration: BoxDecoration(
                    color: Get.isDarkMode ? ColorDarkComponents : Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                margin: EdgeInsets.symmetric(horizontal: 15),
                child: Column(children: [
                  TextSupport(
                      onTap: () {
                        Get.to(_LinkWebView(
                          text: 'Help Center'.tr,
                          conts: 'contact-us',
                        ));
                      },
                      text: 'Help Center'),
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: Get.width * 0.05,
                    ),
                    color: Colors.grey.withOpacity(0.3),
                    height: 1,
                  ),
                  TextSupport(
                      onTap: () {
                        Get.to(_LinkWebView(
                          text: 'Report a Problem',
                          conts: 'contact-us'.tr,
                        ));
                      },
                      text: 'Report a Problem '.tr),
                ])),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'About'.tr,
                style: SafeGoogleFont(Fonts.font3,
                    fontSize: 19, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Get.isDarkMode ? ColorDarkComponents : Colors.white,
                  borderRadius: BorderRadius.circular(10)),
              margin: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  TextSupport(
                      onTap: () {
                        Get.to(_LinkWebView(
                          text: 'About Us'.tr,
                          conts: 'terms/about-us',
                        ));
                      },
                      text: 'About Us'),
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: Get.width * 0.05,
                    ),
                    color: Colors.grey.withOpacity(0.3),
                    height: 1,
                  ),
                  TextSupport(
                      onTap: () {
                        showDialog(
                          context: context,
                          barrierDismissible:
                              true, // set to false if you want to force a rating
                          builder: (context) => _dialog,
                        );
                      },
                      text: 'Rate our App'),
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: Get.width * 0.05,
                    ),
                    color: Colors.grey.withOpacity(0.3),
                    height: 1,
                  ),
                  TextSupport(
                      onTap: () {
                        Get.to(_LinkWebView(
                          text: 'Privacy Policy'.tr,
                          conts: 'terms/privacy-policy',
                        ));
                      },
                      text: 'Privacy Policy'),
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: Get.width * 0.05,
                    ),
                    color: Colors.grey.withOpacity(0.3),
                    height: 1,
                  ),
                  TextSupport(
                      onTap: () {
                        Get.to(_LinkWebView(
                          text: 'Terms of Use'.tr,
                          conts: 'terms/terms',
                        ));
                      },
                      text: 'Terms of Use'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TextSupport extends StatelessWidget {
  TextSupport({
    required this.text,
    this.onTap,
    super.key,
  });

  final String text;
  final onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          if (onTap != null) onTap();
        },
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 3),
          child: Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      // Container(
                      //   height: Get.width * 0.07,
                      //   width: Get.width * 0.07,
                      //   padding: EdgeInsets.all(7),
                      //   decoration: BoxDecoration(
                      //     color: Get.isDarkMode
                      //         ? Color.fromARGB(44, 210, 202, 202)
                      //         : ColorBackIcons,
                      //
                      //     borderRadius: BorderRadius.circular(
                      //         10.0), //Adjust the radius as necessary
                      //   ),
                      //   child: SvgPicture.asset(
                      //     SvgImages.HelpSupport,
                      //     height: Get.height * 0.014,
                      //     width: Get.width * 0.014,
                      //     color: Get.isDarkMode ? Colors.white : ColorTheme,
                      //   ),
                      // ),
                      // SizedBox(
                      //   width: Get.width * 0.03,
                      // ),
                      Text(
                        text,
                        style: SafeGoogleFont(Fonts.font1,
                            fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  Icon(Icons.navigate_next_outlined),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _LinkWebView extends StatefulWidget {
  _LinkWebView({
    super.key,
    required this.conts,
    required this.text,
  });

  final String conts;
  final String text;

  @override
  State<_LinkWebView> createState() => __LinkWebViewState();
}

class __LinkWebViewState extends State<_LinkWebView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.text),
        backgroundColor: Get.isDarkMode ? ColorDarkComponents : Colors.white,
        foregroundColor: Get.isDarkMode ? Colors.white : Colors.black,
      ),
      body: SafeArea(
        child: WebViewWidget(
          controller: WebViewController()
            ..setJavaScriptMode(JavaScriptMode.unrestricted)
            ..setBackgroundColor(const Color(0x00000000))
            ..setNavigationDelegate(
              NavigationDelegate(
                onProgress: (int progress) {
                  // Update loading bar.
                },
                onPageStarted: (String url) {},
                onPageFinished: (String url) {},
                onWebResourceError: (WebResourceError error) {},
                onNavigationRequest: (NavigationRequest request) {
                  if (request.url.startsWith('https://google.com')) {
                    return NavigationDecision.prevent;
                  }
                  return NavigationDecision.navigate;
                },
              ),
            )
            ..loadRequest(Uri.parse('${accounts[0]['sm0']}/${widget.conts}')),
        ),
      ),
    );
  }

// void _handleURLButtonPress(BuildContext context, String url) {
//   Navigator.push(context,
//       MaterialPageRoute(builder: (context) => WebViewContainer(url)));
// }
}
