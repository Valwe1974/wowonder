import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:wowondertimelineflutterapp/Screens/ProfileUserScreen/ProfileUserScreen.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/GetUserDataApi.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Models/GetUserDataModel.dart';

class QrCodeScreen extends StatefulWidget {
  QrCodeScreen({
    super.key,
    required this.user_id,
    required this.avat,
    required this.name,
  });
  String user_id;
  String avat;
  String name;

  @override
  State<QrCodeScreen> createState() => _QrCodeScreenState();
}

class _QrCodeScreenState extends State<QrCodeScreen> {
  int selectedIndex = 0;
  // List<Widget> _widgetOptions = <Widget>[
  //   CreateScreen(
  //       // id: widget.user_id,
  //       ),
  //   ScanScreen(),
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: selectedIndex == 0
            ? CreateScreen(
                avat: widget.avat,
                name: widget.name,
                id: widget.user_id,
              )
            : ScanScreen(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromARGB(52, 249, 160, 160),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.qr_code), label: 'QrCode'),
          BottomNavigationBarItem(
            label: 'Scan Qr Code',
            icon: Icon(
              Icons.qr_code_scanner,
            ),
          ),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        unselectedItemColor: Colors.white,
        fixedColor: Colors.green,
        iconSize: 30,
        onTap: _onItemTapped,
        elevation: 5,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
}

class CreateScreen extends StatefulWidget {
  CreateScreen({
    Key? key,
    required this.avat,
    required this.name,
    required this.id,
  }) : super(key: key);

  String id;
  String name;
  String avat;
  @override
  _CreateScreenState createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.70,
      width: Get.width,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: Get.height * 0.1,
            bottom: Get.height * 0.1,
            left: Get.height * 0.1,
            right: Get.height * 0.1,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(
                    20,
                  )),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                child: Column(
                  children: [
                    SizedBox(
                      height: Get.height * 0.1,
                    ),
                    Text(
                      widget.name,
                      style: GoogleFonts.cairo(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    PrettyQr(
                      image: AssetImage('assets/icon.png'),
                      typeNumber: 3,
                      size: 200,
                      elementColor: Colors.black,
                      data: widget.id,
                      errorCorrectLevel: QrErrorCorrectLevel.M,
                      roundEdges: true,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: Get.height * 0.01,
            bottom: Get.height * 0.5,
            left: Get.width * 0.35,
            right: Get.width * 0.35,
            child: CircleAvatar(
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: CircleAvatar(
                  backgroundColor: Colors.blue,
                  backgroundImage: NetworkImage(widget.avat),
                  maxRadius: 60,
                ),
              ),
            ),
          ),
        ],
      ),
    );
    // Scaffold(
    //   appBar: AppBar(
    //     foregroundColor: Colors.black,
    //     centerTitle: false,
    //     backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    //     title: Text('Creating QR code'),
    //   ),
    //   body: Center(
    //     child: Container(
    //       decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
    //       child: Padding(
    //         padding: const EdgeInsets.all(8.0),
    //         child:
    //       ),
    //     ),
    //   ),
    //   // Column(
    //   //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //   //   crossAxisAlignment: CrossAxisAlignment.center,
    //   //   children: [
    //   //     BarcodeWidget(
    //   //       data: qrstr,

    //   //       barcode: Barcode.qrCode(),
    //   //       color: Colors.blue,
    //   //       height: 250,
    //   //       width: 250,
    //   //     ),
    //   //     Container(
    //   //       alignment: Alignment.center,
    //   //       width: MediaQuery.of(context).size.width * .8,
    //   //       child: TextField(
    //   //         onChanged: (val) {
    //   //           setState(() {
    //   //             qrstr = val;
    //   //           });
    //   //         },
    //   //         decoration: InputDecoration(
    //   //             hintText: 'Enter your data here',
    //   //             border: OutlineInputBorder(
    //   //                 borderSide: BorderSide(color: Colors.blue, width: 2))),
    //   //       ),
    //   //     ),
    //   //     SizedBox(
    //   //       width: MediaQuery.of(context).size.width,
    //   //     )
    //   //   ],
    //   // ),
    // );
  }
}

class ScanScreen extends StatefulWidget {
  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  var qrstr = "let's Scan it";
  var height, width;
  String user_id = '0';
  List<GetUserDataModel> data = [];
  bool truefalse = false;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Center(
      child: truefalse
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () async {
                    if (user_id != '0')
                      Get.to(ProfileUserScreen(
                          avat: data[data.length - 1].avatar,
                          user_id: user_id,
                          cover: data[data.length - 1].cover,
                          name: data[data.length - 1].name));
                  },
                  child: Text(
                    qrstr,
                    style: TextStyle(color: Colors.blue, fontSize: 30),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.1,
                ),
                // ElevatedButton(onPressed: scanQr, child: Text(('Sca'))),
                InkWell(
                  onTap: scanQr,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color.fromARGB(
                          33,
                          255,
                          255,
                          255,
                        ),
                        borderRadius: BorderRadius.circular(30)),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 1),
                      child: Text(
                        'Scan Qr Code',
                        style: GoogleFonts.cairo(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.2,
                )
              ],
            ),
    );
  }

  Future<void> scanQr() async {
    List<GetUserDataModel> datauser = [];
    setState(() {
      datauser.clear();
      truefalse = true;
    });
    try {
      FlutterBarcodeScanner.scanBarcode('#2A99CF', '3444', true, ScanMode.QR)
          .then((value) async {
        print('askjldasdklasjdklasjkdljaskldj $value');
        if (value != '-1') {
          await GetUserDataApi.getUserData(value).then((ameen) {
            setState(() {
              datauser = ameen.toList();
              truefalse = false;
            });
            Get.to(ProfileUserScreen(
                avat: datauser[datauser.length - 1].avatar,
                user_id: datauser[datauser.length - 1].user_id,
                cover: datauser[datauser.length - 1].cover,
                name: datauser[datauser.length - 1].name));
          });
        } else {
          setState(() {
            truefalse = false;
            print(value.toString());
          });
        }
      });
    } catch (e) {
      truefalse = false;
      print('no Qr data');
      setState(() {
        truefalse = false;
        qrstr = 'unable to read this';
      });
    }
  }
}
