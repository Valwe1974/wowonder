import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_paypal/flutter_paypal.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:wowondertimelineflutterapp/Screens/Payment/WidgetPayStack.dart';
import 'package:wowondertimelineflutterapp/Screens/UserScreen/GetMyUserDataCont.dart';
import 'package:wowondertimelineflutterapp/String.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiAddWallet.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiPayStack.dart';
import 'package:wowondertimelineflutterapp/Util/TextUtil.dart';
import 'package:wowondertimelineflutterapp/main.dart';

class MyBalanceScreen extends StatefulWidget {
  const MyBalanceScreen({super.key});

  @override
  State<MyBalanceScreen> createState() => _MyBalanceScreenState();
}

class _MyBalanceScreenState extends State<MyBalanceScreen> {
  @override
  void initState() {
    var cont = Get.put(GetMyUserDataCont());

    super.initState();
  }

  TextEditingController _amount = TextEditingController();
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Get.isDarkMode
            ? ColorDarkBackground
            : Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          title: Text('My Balance'),
          backgroundColor: Get.isDarkMode ? ColorDarkComponents : Colors.white,
          foregroundColor: Get.isDarkMode ? Colors.white : ColorTheme,
        ),
        body: GetX<GetMyUserDataCont>(
          init: GetMyUserDataCont(),
          builder: (controller) {
            return SingleChildScrollView(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color:
                          Get.isDarkMode ? ColorDarkComponents : Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                maxRadius: 31,
                                backgroundColor: Get.isDarkMode
                                    ? Colors.black
                                    : Colors.white,
                                child: CircleAvatar(
                                  maxRadius: 30,
                                  backgroundImage: CachedNetworkImageProvider(
                                      controller
                                          .data[controller.data.length - 1]
                                          .avatar),
                                ),
                              ),
                              SizedBox(
                                width: Get.width * 0.01,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    controller
                                        .data[controller.data.length - 1].name,
                                    style: SafeGoogleFont(Fonts.font1,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Get.isDarkMode
                                            ? Colors.white
                                            : Colors.black),
                                  ),
                                  Text(
                                    '@${controller.data[controller.data.length - 1].username}',
                                    style: SafeGoogleFont(Fonts.font1,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                        color: Colors.grey),
                                  )
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: Get.height * 0.01,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  child: Text(
                                    '\$ ' +
                                        controller
                                            .data[controller.data.length - 1]
                                            .wallet,
                                    style: SafeGoogleFont(Fonts.font1,
                                        color: Get.isDarkMode
                                            ? Colors.white
                                            : Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    'Wallet',
                                    style: SafeGoogleFont(Fonts.font1,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Center(
                    child: Image.asset(
                      'assets/images/Pays.png',
                      height: Get.height * 0.3,
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.04,
                  ),
                  Center(
                      child: Text(
                    'Replenish my balance',
                    style: SafeGoogleFont(Fonts.font1,
                        fontWeight: FontWeight.bold, fontSize: 18),
                  )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '\$',
                        style: SafeGoogleFont(Fonts.font1,
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      SizedBox(
                        width: Get.width * 0.01,
                      ),
                      Container(
                        width: Get.width * 0.1,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: _amount,
                          decoration: InputDecoration(
                              hintText: '00.0',
                              hintStyle: SafeGoogleFont(Fonts.font1,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey)),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Get.height * 0.1,
                  ),
                  InkWell(
                    onTap: () {
                      Get.dialog(Center(
                        child: Container(
                          width: Get.width * 0.80,
                          height: Get.height * 0.30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Scaffold(
                                body: Center(
                              child: Column(
                                children: [
                                  InkWell(
                                      onTap: () async {
                                        Get.back();
                                        Get.to(WidgetPayStack(
                                            amount: _amount.text,
                                            update: () {
                                              controller.updi();
                                            }));
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                            'assets/svg/paystack.svg',
                                            height: Get.height * 0.05,
                                          ),
                                          SizedBox(
                                            width: Get.width * 0.01,
                                          ),
                                          Text(
                                            'PayStack',
                                            style: SafeGoogleFont(Fonts.font1,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                          )
                                        ],
                                      )),
                                  Divider(),
                                  if (GetSetList[0]['paypal'] == 'yes')
                                    TextButton(
                                        onPressed: () => {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (BuildContext
                                                          context) =>
                                                      UsePaypal(
                                                          sandboxMode: true,
                                                          clientId:
                                                              GetSetList[
                                                                      0][
                                                                  'paypal_id'],
                                                          secretKey: GetSetList[
                                                                  0][
                                                              'paypal_secret'],
                                                          returnURL:
                                                              "https://samplesite.com/return",
                                                          cancelURL:
                                                              "https://samplesite.com/cancel",
                                                          transactions: [
                                                            {
                                                              "amount": {
                                                                "total":
                                                                    '${_amount.text}',
                                                                "currency":
                                                                    "USD",
                                                                "details": {
                                                                  "subtotal":
                                                                      _amount
                                                                          .text,
                                                                  "shipping":
                                                                      '0',
                                                                  "shipping_discount":
                                                                      0
                                                                }
                                                              },
                                                              "description":
                                                                  "The payment transaction description.",
                                                              // "payment_options": {
                                                              //   "allowed_payment_method":
                                                              //       "INSTANT_FUNDING_SOURCE"
                                                              // },

                                                              "item_list": {
                                                                "items": [
                                                                  {
                                                                    "name":
                                                                        "Charging the wallet $nameApp",
                                                                    "quantity":
                                                                        1,
                                                                    "price":
                                                                        _amount
                                                                            .text,
                                                                    "currency":
                                                                        "USD"
                                                                  }
                                                                ],

                                                                // shipping address is not required though
                                                                "shipping_address":
                                                                    {
                                                                  "recipient_name":
                                                                      "Jane Foster",
                                                                  "line1":
                                                                      "Travis County",
                                                                  "line2": "",
                                                                  "city":
                                                                      "Austin",
                                                                  "country_code":
                                                                      "US",
                                                                  "postal_code":
                                                                      "73301",
                                                                  "phone":
                                                                      "+00000000",
                                                                  "state":
                                                                      "Texas"
                                                                },
                                                              }
                                                            }
                                                          ],
                                                          note:
                                                              "Contact us for any questions on your order.",
                                                          onSuccess: (Map
                                                              params) async {
                                                            print(
                                                                "onSuccess: ${params['data']['transactions'][0]['amount']['total']}");

                                                            await ApiAddWallet.add(
                                                                u: controller
                                                                    .data[controller
                                                                            .data
                                                                            .length -
                                                                        1]
                                                                    .user_id,
                                                                p: _amount
                                                                    .text);
                                                            controller.updi();
                                                            Get.put(
                                                                GetMyUserDataCont());
                                                            Get.back();
                                                            Get.snackbar(
                                                                params['data']['transactions']
                                                                            [0][
                                                                        'amount']
                                                                    ['total'],
                                                                'Payment successful');
                                                          },
                                                          onError: (error) {
                                                            print(
                                                                "onError: $error");
                                                          },
                                                          onCancel: (params) {
                                                            print(
                                                                'cancelled: $params');
                                                            Get.snackbar('',
                                                                'cancelled');
                                                          }),
                                                ),
                                              )
                                            },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                                'assets/images/paypal (1).png'),
                                            SizedBox(
                                              width: Get.width * 0.01,
                                            ),
                                            Text(
                                              'PayPal',
                                              style: SafeGoogleFont(Fonts.font1,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                            )
                                          ],
                                        )),
                                  if (accounts[0]['sm0'] ==
                                      'https://demo.ameenhost.com')
                                    Column(
                                      children: [
                                        Text(
                                            'PayPal Test Demo Wowonder Flutter'),
                                        GestureDetector(
                                          onLongPress: () {
                                            Clipboard.setData(new ClipboardData(
                                                text:
                                                    'sb-jf4qg25845658@personal.example.com'));
                                            Get.snackbar('Copy',
                                                'Copied to sb-jf4qg25845658@personal.example.com');
                                          },
                                          child: Text(
                                            'Email:-  sb-jf4qg25845658@personal.example.com',
                                            style: SafeGoogleFont(Fonts.font1,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        GestureDetector(
                                          onLongPress: () {
                                            Clipboard.setData(new ClipboardData(
                                                text: '123456789'));
                                            Get.snackbar(
                                                'Copy', 'Copied to 123456789');
                                          },
                                          child: Text(
                                            'Passwotd:-  123456789',
                                            style: SafeGoogleFont(Fonts.font1,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    )
                                ],
                              ),
                            )),
                          ),
                        ),
                      ));
                    },
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                            color: ColorTheme,
                            borderRadius: BorderRadius.circular(5)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 8),
                          child: Text(
                            'Continue',
                            style: SafeGoogleFont(Fonts.font2,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ));
          },
        ));
  }
}
