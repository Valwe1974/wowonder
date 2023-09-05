import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiPayStack.dart';
import 'package:wowondertimelineflutterapp/Util/TextUtil.dart';
import 'package:wowondertimelineflutterapp/main.dart';

class WidgetPayStack extends StatefulWidget {
  const WidgetPayStack({
    required this.amount,
    required this.update,
    super.key,
  });

  final String amount;
  final update;

  @override
  State<WidgetPayStack> createState() => _WidgetPayStackState();
}

class _WidgetPayStackState extends State<WidgetPayStack> {
  @override
  TextEditingController _email = TextEditingController();
  TextEditingController _ConfEmail = TextEditingController();
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PayStack'),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        foregroundColor: Get.isDarkMode ? Colors.white : ColorTheme,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text(
                  'PayStack',
                  style: SafeGoogleFont(Fonts.font1,
                      fontWeight: FontWeight.bold, fontSize: 22),
                ),
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: Get.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: TextField(
                        controller: _email,
                        decoration: InputDecoration(
                            border: InputBorder.none, hintText: 'Email')),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: Get.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: TextField(
                        controller: _ConfEmail,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Confirm Email')),
                  ),
                ),
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              InkWell(
                onTap: () async {
                  if (_email.text == _ConfEmail.text) {
                    if (_email.text.isNotEmpty) {
                      var ameen = await ApiPayStack.pay(
                          e: _email.text, am: int.parse(widget.amount));
                      print(ameen);
                      if (ameen['api_status'] == '400') {
                        print(ameen['errors']['error_text']);
                      } else if (ameen['api_status'] == 200) {
                        Get.to(_PayStackView(
                          webUrlStac: ameen['url'],
                          amount: int.parse(widget.amount),
                          update: widget.update,
                        ));
                        _email.clear();
                        _ConfEmail.clear();
                      }
                    } else {
                      Get.snackbar('errors', 'Please enter your e-mail');
                    }
                  } else {
                    print('asdasdasdasd');
                    Get.snackbar('errors', 'Email does not match');
                  }
                },
                child: Center(
                  child: Container(
                    width: Get.width * 0.30,
                    decoration: BoxDecoration(
                        color: ColorTheme,
                        borderRadius: BorderRadius.circular(3)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          'Submit',
                          style: SafeGoogleFont(
                            Fonts.font1,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Get.isDarkMode ? Colors.black : Colors.white,
                      borderRadius: BorderRadius.circular(3)),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Please enter the correct email. You will receive an email containing a code to confirm the shipment of the wallet',
                          style: SafeGoogleFont(
                            Fonts.font1,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Image.asset(
                        'assets/images/ecommerce-payment-e1681212138441 copy.png',
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _PayStackView extends StatelessWidget {
  const _PayStackView({
    super.key,
    required this.amount,
    required this.webUrlStac,
    required this.update,
  });

  final int amount;
  final String webUrlStac;
  final update;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Get.isDarkMode ? Colors.black : Colors.white,
        foregroundColor: Get.isDarkMode ? Colors.white : ColorTheme,
        title: Text('Pay '),
      ),
      body: WebViewWidget(
          controller: WebViewController()
            ..setJavaScriptMode(JavaScriptMode.unrestricted)
            ..setBackgroundColor(const Color(0x00000000))
            ..setNavigationDelegate(
              NavigationDelegate(
                onProgress: (int progress) {
                  print('onPageStarted $progress');
                },
                onPageStarted: (String url) {
                  print('onPageStarted $url');
                  var ext = url.toLowerCase();
                  if (ext.startsWith(
                      '${accounts[0]['sm0']}/requests.php?f=paystack&s=wallet')) {
                    Get.back();
                    Get.to(_AddMonyWillt(
                        amount: amount.toString(), update: update));
                  }
                },
                onPageFinished: (String url) {
                  print('onPageFinished $url');
                },
                onWebResourceError: (WebResourceError error) {
                  print('onWebResourceError $error');
                },
                onNavigationRequest: (NavigationRequest request) {
                  if (request.url.startsWith('https://google.com')) {
                    return NavigationDecision.prevent;
                  }
                  return NavigationDecision.navigate;
                },
              ),
            )
            ..loadRequest(Uri.parse(webUrlStac))),
    );
  }
}

class _AddMonyWillt extends StatefulWidget {
  const _AddMonyWillt({super.key, required this.amount, required this.update});
  final String amount;
  final update;

  @override
  State<_AddMonyWillt> createState() => _AddMonyWilltState();
}

class _AddMonyWilltState extends State<_AddMonyWillt> {
  TextEditingController _Reference = TextEditingController();
  bool isFalse = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add money code'),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        foregroundColor: Get.isDarkMode ? Colors.white : ColorTheme,
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Text(
            'PayStack',
            style: SafeGoogleFont(Fonts.font1,
                fontWeight: FontWeight.bold, fontSize: 22),
          ),
        ),
        SizedBox(
          height: Get.height * 0.01,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: Get.width,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(6)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: TextField(
                  controller: _Reference,
                  decoration: InputDecoration(
                      border: InputBorder.none, hintText: 'Reference')),
            ),
          ),
        ),
        SizedBox(
          height: Get.height * 0.01,
        ),
        InkWell(
          onTap: () async {
            var ameen = await ApiPayStackAdd.pay(
                am: widget.amount, reference: _Reference.text);
            print(ameen);
            if (ameen['api_status'] == '400') {
              print(ameen['errors']['error_text']);
              Get.snackbar('Error', ameen['errors']['error_text']);
            } else if (ameen['api_status'] == 200) {
              Get.back();
              Get.snackbar(ameen['message'],
                  'Your wallet has been charged ${widget.amount}');
              widget.update();
            }
            ;
          },
          child: Center(
            child: Container(
              width: Get.width * 0.30,
              decoration: BoxDecoration(
                  color: ColorTheme, borderRadius: BorderRadius.circular(3)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    'Submit',
                    style: SafeGoogleFont(
                      Fonts.font1,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Divider(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                color: Get.isDarkMode ? Colors.black : Colors.white,
                borderRadius: BorderRadius.circular(3)),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Please enter the reference code you received from Paystack',
                    style: SafeGoogleFont(
                      Fonts.font1,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Image.asset(
                  'assets/images/ecommerce-payment-e1681212138441 copy.png',
                )
              ],
            ),
          ),
        )
      ]),
    );
  }
}
