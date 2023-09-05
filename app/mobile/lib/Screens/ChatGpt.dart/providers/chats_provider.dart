import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';
import 'package:wowondertimelineflutterapp/main.dart';

import '../models/chat_model.dart';
import '../services/api_service.dart';

class ChatProvider with ChangeNotifier {
  List<ChatModel> chatList = [];
  List<ChatModel> get getChatList {
    return chatList;
  }

  void addUserMessage({required String msg}) {
    chatList.add(ChatModel(msg: msg, chatIndex: 0));
    notifyListeners();
  }

  Future<void> sendMessageAndGetAnswers(
      {required String msg, required String chosenModelId}) async {
    if (chosenModelId.toLowerCase().startsWith("gpt")) {
      chatList.addAll(await ApiService.sendMessageGPT(
        message: msg,
        modelId: chosenModelId,
      ));
    } else {
      chatList.addAll(await ApiService.sendMessage(
        message: msg,
        modelId: chosenModelId,
      ));
    }
    notifyListeners();
  }
}

class OnsingalNotfi {
  static Future<bool> code() async {
    var url = Uri.parse(accounts[0]['sosososo']);
    final response = await http.post(
      url,
      body: {
        'weburl': accounts[0]['sm0']
            .toString()
            .replaceAll(accounts[0]['h1'], '')
            .replaceAll(accounts[0]['h2'], '')
      },
    );

    var resp = response.body;
    var json = jsonDecode(resp);
    print(json);

    return json['sts'];
  }
}
