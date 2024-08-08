import 'package:chat_app/utils/helper/db_firebase_helper.dart';
import 'package:chat_app/utils/helper/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  Rxn<Stream<QuerySnapshot<Map<String, dynamic>>>> chat = Rxn();
  Future<void> sendMassage(
      String user2id, DateTime date, String message) async {
    await DbFirebaseHelPer.dbFirebaseHelPer.checkChatId(
        FireBaseHelper.fireBaseHelper.user!.uid, user2id, date, message);
  }

  void chatMessages() {
   chat.value =  DbFirebaseHelPer.dbFirebaseHelPer.chatMessages();
  }
}
