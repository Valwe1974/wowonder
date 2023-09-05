import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wowondertimelineflutterapp/Screens/Reaction/ReactionComment.dart';
import 'package:wowondertimelineflutterapp/Screens/UserScreen/GetMyUserDataCont.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/CreateCommentsApi.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/GetCommetsApi.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Models/CommentsModel.dart';
import 'package:wowondertimelineflutterapp/Util/TextUtil.dart';

// ignore: must_be_immutable
class ReplayCommentScreen extends StatefulWidget {
  ReplayCommentScreen(
      {super.key, required this.post_id, required this.fetch_comments});
  String post_id;
  String fetch_comments;
  @override
  State<ReplayCommentScreen> createState() => _ReplayCommentScreenState();
}

class _ReplayCommentScreenState extends State<ReplayCommentScreen> {
  List<GetCommentsModel> data = [];
  void getCommentsApi() {
    GetCommentsApi.FetchComments(widget.post_id, widget.fetch_comments, '0')
        .then((value) {
      setState(() {
        data = value.toList();
      });
    });
  }

  bool loding = true;
  bool noData = true;
  String text = '';
  TextEditingController textfiled = TextEditingController();
  ScrollController _scrollController = ScrollController();
  scrollToCursor(String textFieldValue) {
    final isLonger = textFieldValue.length > text.length;
    setState(() {
      text = textFieldValue;
    });
    print(text.length);
    if (isLonger)
      _scrollController.animateTo(_scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300), curve: Curves.ease);
  }

  @override
  void initState() {
    getCommentsApi();

    super.initState();
  }

  XFile? ImagePost;
  XFile? videoUp;
  String? filename;
  final ImagePicker _picker = ImagePicker();
  String imagefile = '';
  Future<void> UplodeImageComments(send) async {
    await Permission.storage.request();
    await Permission.photos.request();
    final XFile? image = await _picker.pickImage(source: send);
    setState(() {
      print(_picker);
      ImagePost = image;
      print(ImagePost!.path);
    });
  }

  final getimydata = Get.put(GetMyUserDataCont());
  void _addComments(
    text1,
    c_file,
  ) async {
    Get.find<GetMyUserDataCont>();

    print('text $text');

    for (var i = 0; i < getimydata.data.length; i++)
      setState(() {
        data.add(GetCommentsModel(
            type: '',
            comment_id: '',
            reaction: 0,
            reaction1: 0,
            id: '',
            text: text1 == '' ? '' : text1,
            avatar: getimydata.data[i].avatar,
            name: getimydata.data[i].name,
            c_file: c_file == null ? '' : c_file,
            comments_status: '0',
            replies: '0'));

        noData = false;
      });
    var senposts = await CreateCommentsApi.CreateComments(
        widget.post_id,
        textfiled.text == '' ? null : textfiled.text,
        ImagePost != null ? ImagePost!.path : null,
        'create_reply');
    @override
    void initState() {
      getCommentsApi();

      super.initState();
    }
  }

  Widget build(BuildContext context) {
    print(widget.post_id);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        decoration: BoxDecoration(
            color: Get.isDarkMode ? Colors.black : Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 2,
              ),
            ],
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        width: Get.width,
        child: Row(children: [
          SizedBox(
            width: Get.width * 0.04,
          ),
          Icon(Icons.more_vert),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  color: const Color.fromARGB(96, 158, 158, 158),
                  borderRadius: BorderRadius.circular(20)),
              width: Get.width * 0.74,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                  onChanged: (value) {
                    scrollToCursor(value);
                  },
                  controller: textfiled,
                  scrollController: _scrollController,
                  maxLength: null,
                  maxLines: null,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ),
          IconButton(
              onPressed: () {
                _addComments(textfiled.text, '');
              },
              icon: Icon(Icons.send))
        ]),
      ),
      appBar: AppBar(
        title: Text('Replay Comment'.tr),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              for (var i = 0; i < data.length; i++)
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage: CachedNetworkImageProvider(
                                      data[i].avatar),
                                ),
                                SizedBox(
                                  width: Get.width * 0.01,
                                ),
                                Text(
                                  data[i].name,
                                  style: SafeGoogleFont(Fonts.font3,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            IconButton(
                                onPressed: () {}, icon: Icon(Icons.more_horiz))
                          ],
                        ),

                        ///comments all tex
                        ///
                        ///
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(data[i].text),
                        ),

                        Row(
                          children: [
                            ReqctionComment(
                              contt: 2,
                              imReaction: null,
                              comments_id: '',
                            ),
                            SizedBox(
                              width: Get.width * 0.01,
                            ),
                            Text(data[i].reaction.toString()),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
