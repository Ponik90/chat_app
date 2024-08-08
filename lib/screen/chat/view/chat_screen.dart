import 'dart:async';

import 'package:chat_app/screen/chat/controller/chat_controller.dart';
import 'package:chat_app/screen/chat/model/chat_model.dart';
import 'package:chat_app/screen/user/model/user_model.dart';
import 'package:chat_app/utils/helper/db_firebase_helper.dart';
import 'package:chat_app/utils/helper/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
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
  FocusNode node = FocusNode();
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    controller.chatMessages();
    node.addListener(
      () {
        if (node.hasFocus) {
          Future.delayed(
              const Duration(milliseconds: 300),
              scrollController.animateTo(
                  scrollController.position.maxScrollExtent,
                  duration: const Duration(seconds: 1),
                  curve: Curves.fastOutSlowIn) as FutureOr Function()?);
        }
      },
    );
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
              Expanded(
                child: Obx(
                  () => StreamBuilder(
                    stream: controller.chat.value,
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
                                return chatModelList[index].uid ==
                                        FireBaseHelper.fireBaseHelper.user!.uid
                                    ? ChatBubble(
                                        clipper: ChatBubbleClipper8(
                                          type: BubbleType.sendBubble,
                                        ),
                                        margin: const EdgeInsets.only(top: 5),
                                        alignment: Alignment.centerRight,
                                        elevation: 2,
                                        child: InkWell(
                                          onLongPress: () {
                                            if (chatModelList[index].uid ==
                                                FireBaseHelper
                                                    .fireBaseHelper.user!.uid) {
                                              Get.defaultDialog(
                                                title: "delete chat",
                                                actions: [
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      Get.back();
                                                    },
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                          const Color(
                                                              0xffdd4545),
                                                    ),
                                                    child: const Text(
                                                      "Cansel",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      DbFirebaseHelPer
                                                          .dbFirebaseHelPer
                                                          .deleteMyChat(
                                                              chatModelList[
                                                                      index]
                                                                  .docId!);
                                                      Get.back();
                                                    },
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                          const Color(
                                                              0xff458ddd),
                                                    ),
                                                    child: const Text(
                                                      "Delete",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            }
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.all(10),
                                            child: Text(
                                              "${chatModelList[index].message}",
                                              style: const TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    : ChatBubble(
                                        clipper: ChatBubbleClipper8(
                                          type: BubbleType.receiverBubble,
                                        ),
                                        elevation: 2,
                                        backGroundColor: Colors.grey.shade300,
                                        alignment: Alignment.centerLeft,
                                        child: InkWell(
                                          onLongPress: () {
                                            if (chatModelList[index].uid ==
                                                FireBaseHelper
                                                    .fireBaseHelper.user!.uid) {
                                              Get.defaultDialog(
                                                title: "delete chat",
                                                actions: [
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      Get.back();
                                                    },
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                          const Color(
                                                              0xffdd4545),
                                                    ),
                                                    child: const Text(
                                                      "Cansel",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      DbFirebaseHelPer
                                                          .dbFirebaseHelPer
                                                          .deleteMyChat(
                                                              chatModelList[
                                                                      index]
                                                                  .docId!);
                                                      Get.back();
                                                    },
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                          const Color(
                                                              0xff458ddd),
                                                    ),
                                                    child: const Text(
                                                      "Delete",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            }
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(5),
                                            child: Text(
                                                "${chatModelList[index].message}"),
                                          ),
                                        ),
                                      );
                              },
                            ),
                          );
                        }
                      }
                      return const Center(child: CircularProgressIndicator());
                    },
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      focusNode: node,
                      controller: txtMessage,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(
                            color: Color(0xff084759),
                          ),
                        ),
                        hintText: "type message",
                        hintStyle: TextStyle(color: Colors.blue.shade300),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xff084759),
                          ),
                        ),
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
                          controller.chatMessages();
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
