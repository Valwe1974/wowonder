import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/GetAllReactionApi.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Models/GetAllReactionModel.dart';

import '../../Images.dart';

class GetAllRectionScreen extends StatefulWidget {
  GetAllRectionScreen({required this.reply, required this.id, super.key});
  String id;
  String reply;
  @override
  State<GetAllRectionScreen> createState() => _GetAllRectionScreenState();
}

class _GetAllRectionScreenState extends State<GetAllRectionScreen> {
  bool lod = false;
  List<GetAllReactionModel> data = [];
  String nump = '1';
  GetAllData() async {
    setState(() {
      lod = true;
    });
    GetAllReactionApi.fetchReaction(widget.id, nump, nump, widget.reply)
        .then((value) => {
              setState(() {
                data = value.toList();
                lod = false;
              }),
            });
  }

  @override
  void initState() {
    GetAllData();
    super.initState();
  }

  void _OnTap(num) {
    setState(() {
      data = [];
      nump = num;
    });
    GetAllData();
  }

  @override
  Widget build(BuildContext context) {
    //1,2,3,4,5,6,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27
    return Scaffold(
      appBar: AppBar(
          title: Text('Reaction'.tr),
          bottom: Tab(
              child: Container(
            width: Get.width,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: SingleChildScrollView(
                  dragStartBehavior: DragStartBehavior.start,
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () => _OnTap('1'),
                        child: _WidgetRaction(
                          iconimag: 'like.gif',
                        ),
                      ),
                      InkWell(
                        onTap: () => _OnTap('2'),
                        child: _WidgetRaction(
                          iconimag: 'love.gif',
                        ),
                      ),
                      InkWell(
                        onTap: () => _OnTap('3'),
                        child: _WidgetRaction(
                          iconimag: 'haha.gif',
                        ),
                      ),
                      InkWell(
                        onTap: () => _OnTap('4'),
                        child: _WidgetRaction(
                          iconimag: 'wow.gif',
                        ),
                      ),
                      InkWell(
                        onTap: () => _OnTap('5'),
                        child: _WidgetRaction(
                          iconimag: 'sad.gif',
                        ),
                      ),
                      InkWell(
                        onTap: () => _OnTap('6'),
                        child: _WidgetRaction(
                          iconimag: 'angry.gif',
                        ),
                      ),
                    ],
                  )),
            ),
          ))),
      body: lod
          ? Center(child: CircularProgressIndicator())
          : data.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/images/svg/smiley-frown-svgrepo-com.svg',
                        height: Get.height * 0.40,
                        width: Get.width * 0.40,
                        color: ColorTheme,
                      ),
                      Text(
                        'There are no likes',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w700,
                            fontSize: 17,
                            color: ColorTheme),
                      )
                    ],
                  ),
                )
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        for (var i = 0; i < data.length; i++)
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Stack(
                                      children: [
                                        CircleAvatar(
                                          radius: 27,
                                          child: CircleAvatar(
                                            radius: 24,
                                            backgroundImage:
                                                NetworkImage(data[i].avatar),
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 0,
                                          child: Row(
                                            children: [
                                              if (nump == '1')
                                                _WidgetRaction(
                                                  iconimag: 'like.gif',
                                                ),
                                              if (nump == '2')
                                                _WidgetRaction(
                                                  iconimag: 'love.gif',
                                                ),
                                              if (nump == '3')
                                                _WidgetRaction(
                                                  iconimag: 'haha.gif',
                                                ),
                                              if (nump == '4')
                                                _WidgetRaction(
                                                  iconimag: 'wow.gif',
                                                ),
                                              if (nump == '5')
                                                _WidgetRaction(
                                                  iconimag: 'sad.gif',
                                                ),
                                              if (nump == '6')
                                                _WidgetRaction(
                                                  iconimag: 'angry.gif',
                                                ),
                                              if (nump == '10')
                                                _SmaileIconsWidget(
                                                  smailey: '😀', //Grinning Face
                                                ),
                                              if (nump == '11')
                                                _SmaileIconsWidget(
                                                  smailey: '😁', //Grinning Face
                                                ),
                                              if (nump == '12')
                                                _SmaileIconsWidget(
                                                  smailey: '🫠', //Grinning Face
                                                ),
                                              if (nump == '13')
                                                _SmaileIconsWidget(
                                                  smailey: '😇', //Grinning Face
                                                ),
                                              if (nump == '14')
                                                _SmaileIconsWidget(
                                                  smailey: '🤩', //Grinning Face
                                                ),
                                              if (nump == '15')
                                                _SmaileIconsWidget(
                                                  smailey: '😛', //Grinning Face
                                                ),
                                              if (nump == '16')
                                                _SmaileIconsWidget(
                                                  smailey: '👊', //Grinning Face
                                                ),
                                              if (nump == '17')
                                                _SmaileIconsWidget(
                                                  smailey: '🤝', //Grinning Face
                                                ),
                                              if (nump == '18')
                                                _SmaileIconsWidget(
                                                  smailey: '💪', //Grinning Face
                                                ),
                                              if (nump == '19')
                                                _SmaileIconsWidget(
                                                  smailey: '👱', //Grinning Face
                                                ),
                                              if (nump == '20')
                                                _SmaileIconsWidget(
                                                  smailey: '👩', //Grinning Face
                                                ),
                                              if (nump == '21')
                                                _SmaileIconsWidget(
                                                  smailey:
                                                      '🙍‍♂️', //Grinning Face
                                                ),
                                              if (nump == '22')
                                                _SmaileIconsWidget(
                                                  smailey: '🤔', //Grinning Face
                                                ),
                                              if (nump == '23')
                                                _SmaileIconsWidget(
                                                  smailey: '🫥', //Grinning Face
                                                ),
                                              if (nump == '24')
                                                _SmaileIconsWidget(
                                                  smailey: '🥵', //Grinning Face
                                                ),
                                              if (nump == '25')
                                                _SmaileIconsWidget(
                                                  smailey: '🥳', //Grinning Face
                                                ),
                                              if (nump == '26')
                                                _SmaileIconsWidget(
                                                  smailey: '💀', //Grinning Face
                                                ),
                                              if (nump == '27')
                                                _SmaileIconsWidget(
                                                  smailey: '💋', //Grinning Face
                                                ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: Get.width * 0.01,
                                    ),
                                    Text(
                                      data[i].name,
                                      style: GoogleFonts.cairo(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 15),
                                    ),
                                  ],
                                ),
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.more_horiz_rounded)),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
    );
  }
}

class _SmaileIconsWidget extends StatelessWidget {
  _SmaileIconsWidget({required this.smailey, super.key});
  String smailey;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          smailey,
          style: TextStyle(fontSize: 30),
        ),
        SizedBox(
          width: Get.width * 0.02,
        ),
      ],
    );
  }
}

class _WidgetRaction extends StatelessWidget {
  _WidgetRaction({
    required this.iconimag,
    super.key,
  });
  String iconimag;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: Get.width * 0.045,
        ),
        Center(
          child: Image.asset(
            pathReactionsAnimated+'${iconimag}',
            width: 30,
            height: 30,
          ),
        ),
        SizedBox(
          width: Get.width * 0.045,
        ),
      ],
    );
  }
}
