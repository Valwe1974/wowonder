import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wowondertimelineflutterapp/Screens/ProfileUserScreen/ProfileUserScreen.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiFetchPokes.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Models/PokesModel.dart';
import 'package:wowondertimelineflutterapp/Util/TextUtil.dart';
import 'package:wowondertimelineflutterapp/Widget/NotFoundWidget.dart';
import 'package:wowondertimelineflutterapp/Widget/ScaffoldWidget.dart';

class HomePoksScreen extends StatefulWidget {
  const HomePoksScreen({super.key});

  @override
  State<HomePoksScreen> createState() => _HomePoksScreenState();
}

class _HomePoksScreenState extends State<HomePoksScreen> {
  bool lod = true;
  bool impaty = false;
  List<PokesModel> pok = [];
  void getPokes() {
    ApiFetcPokes.GetBlock().then((value) {
      setState(() {
        pok = value.toList();
        lod = false;
        if (value.length == 0) impaty = true;
      });
    });
  }

  @override
  void initState() {
    getPokes();
    super.initState();
  }

  bool pkes = false;
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      AppBarTrueOrFalse: true,
      title: 'Pokes'.tr,
      centerTitle: false,
      elevation: 2,
      loding: false,
      body: lod
          ? Center(
              child: CircularProgressIndicator(),
            )
          : impaty
              ? NotFoundWidget(text: 'There are no pokes'.tr)
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      for (var i = 0; i < pok.length; i++)
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Get.to(ProfileUserScreen(
                                          avat: pok[i].avatar,
                                          user_id: pok[i].user_id,
                                          cover: pok[i].cover,
                                          name: pok[i].name));
                                    },
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          maxRadius: 28,
                                          child: CircleAvatar(
                                            maxRadius: 25,
                                            backgroundImage:
                                                CachedNetworkImageProvider(
                                                    pok[i].avatar),
                                          ),
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              pok[i].name,
                                              style: SafeGoogleFont(Fonts.font1,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 17),
                                            ),
                                            Text(
                                              pok[i].dt,
                                              style: SafeGoogleFont(Fonts.font1,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 14,
                                                  color: Colors.grey),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          ApiRemovePoke.GetBlock(pok[i].id);
                                          setState(() {
                                            pok.removeAt(i);
                                            if (pok.length == 0) impaty = true;
                                          });
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: const Color.fromARGB(
                                                255, 96, 12, 7),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              'Remove',
                                              style: SafeGoogleFont(Fonts.font1,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: Get.width * 0.01,
                                      ),
                                      _pkes(pkes: pkes, use: pok[i].user_id)
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Divider()
                          ],
                        ),
                    ],
                  ),
                ),
    );
  }
}

class _pkes extends StatefulWidget {
  _pkes({
    super.key,
    required this.pkes,
    required this.use,
  });

  bool pkes;
  String use;

  @override
  State<_pkes> createState() => _pkesState();
}

class _pkesState extends State<_pkes> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (widget.pkes) {
        } else {
          setState(() {
            widget.pkes = true;
          });
          var ameen = await ApiSendPoke.Send(widget.use);
          // print(ameen);
          if (ameen['api_status'] == 200) {
            Get.snackbar('Message', ameen['message_data']);
          } else {
            Get.snackbar('Erorr', ameen['errors']['error_text']);
          }
        }
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: widget.pkes ? Colors.grey : ColorTheme,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Poke'.tr,
            style: SafeGoogleFont(Fonts.font1,
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
