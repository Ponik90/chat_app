import 'package:chat_app/screen/chat/controller/chat_controller.dart';
import 'package:chat_app/screen/chat/model/chat_model.dart';
import 'package:chat_app/screen/user/model/user_model.dart';
import 'package:chat_app/utils/helper/db_firebase_helper.dart';
import 'package:chat_app/utils/helper/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  UserModel model = Get.arguments;
  ChatController controller = Get.put(ChatController());
  TextEditingController txtMessage = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.chatMessages();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus!.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("${model.name}"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              StreamBuilder(
                stream: DbFirebaseHelPer.dbFirebaseHelPer.chatMessages(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text("Let's Started"),
                    );
                  } else if (snapshot.hasData) {
                    List<ChatModel> chatModelList = [];
                    QuerySnapshot? qs = snapshot.data;
                    List<QueryDocumentSnapshot> l1 = qs!.docs;
                    for (var x in l1) {
                      var id = x.id;
                      Map m1 = x.data() as Map;

                      ChatModel model = ChatModel.mapToModel(m1);
                      model.docId = id;

                      chatModelList.add(model);
                    }

                    if (chatModelList.isEmpty) {
                      return const Center(
                        child: Text("Let's started"),
                      );
                    } else {
                      return Expanded(
                        child: ListView.builder(
                          itemCount: chatModelList.length,
                          itemBuilder: (context, index) {
                            return Align(
                              alignment: chatModelList[index].uid ==
                                      FireBaseHelper.fireBaseHelper.user!.uid
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                              child: InkWell(
                                  onLongPress: () {
                                    if (chatModelList[index].uid ==
                                        FireBaseHelper
                                            .fireBaseHelper.user!.uid) {
                                      Get.defaultDialog(
                                        title: "delete chat",
                                        actions: [
                                          IconButton(
                                            onPressed: () {
                                              Get.back();
                                            },
                                            icon: const Icon(Icons.cancel),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              DbFirebaseHelPer.dbFirebaseHelPer
                                                  .deleteMyChat(
                                                      chatModelList[index]
                                                          .docId!);
                                              Get.back();
                                            },
                                            icon: const Icon(Icons.delete),
                                          ),
                                        ],
                                      );
                                    }
                                  },
                                  child:
                                      Text("${chatModelList[index].message}")),
                            );
                          },
                        ),
                      );
                    }
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
              const Spacer(),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: txtMessage,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  CircleAvatar(
                    backgroundColor: const Color(0xff458ddd),
                    radius: 25,
                    child: IconButton(
                      onPressed: () {
                        if (txtMessage.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("please enter the message"),
                            ),
                          );
                        } else {
                          controller.sendMassage(
                              model.id!, DateTime.now(), txtMessage.text);
                          DbFirebaseHelPer.dbFirebaseHelPer.chatMessages();
                        }
                      },
                      color: Colors.white,
                      icon: const Icon(
                        Icons.send,
                        size: 30,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
