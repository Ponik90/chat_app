import 'package:chat_app/screen/chat/model/chat_model.dart';
import 'package:chat_app/screen/profile/model/profile_model.dart';
import 'package:chat_app/utils/helper/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DbFirebaseHelPer {
  static DbFirebaseHelPer dbFirebaseHelPer = DbFirebaseHelPer._();

  DbFirebaseHelPer._();

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String? userUid;
  String? id;

  //user uid
  void getUserUid() {
    userUid = FireBaseHelper.fireBaseHelper.user!.uid;
  }

  //user personal data
  Future<void> userProfile(ProfileModel m1) async {
    getUserUid();

    await firestore.collection('user').doc(userUid).set(m1.modelToMap());
  }

  //get user data
  Future<ProfileModel> currentUser() async {
    getUserUid();
    DocumentSnapshot ds = await firestore.collection('user').doc(userUid).get();
    Map? model = ds.data() as Map?;
    ProfileModel data = ProfileModel.mapToModel(
        model ?? {"name": "", "email": "", "phone": ""});
    return data;
  }

  // all app user
  Future<List<ProfileModel>> getAllUser(ProfileModel p1) async {
    List<ProfileModel> listData = [];
    QuerySnapshot qs = await firestore
        .collection('user')
        .where("phone", isEqualTo: p1.phone)
        .get();
    List<QueryDocumentSnapshot> document = qs.docs;

    for (var x in document) {
      var ket = x.id;
      Map m1 = x.data() as Map;

      ProfileModel model = ProfileModel.mapToModel(m1);
      model.id = ket;
      listData.add(model);
    }
    return listData;
  }

  // find chat id
  Future<void> checkChatId(
      String myId, String user2id, DateTime date, String message) async {
    if (id == null) {
      DocumentReference dr = await firestore
          .collection('chat')
          .add({'Userid1': myId, 'Userid2': user2id});

      id = dr.id;
      sendMessage(id: id!, message: message, date: date);
    } else {
      sendMessage(id: id!, message: message, date: date);
    }
  }

  Future<String?> getChatDocId(String myId, String user2id) async {
    QuerySnapshot qs = await firestore
        .collection('chat')
        .where('Userid1', isEqualTo: myId)
        .where('Userid2', isEqualTo: user2id)
        .get();
    List<QueryDocumentSnapshot> l1 = qs.docs;
    if (l1.isNotEmpty) {
      id = l1[0].id;
      return id;
    } else {
      QuerySnapshot qs = await firestore
          .collection('chat')
          .where('Userid2', isEqualTo: myId)
          .where('Userid1', isEqualTo: user2id)
          .get();
      List<QueryDocumentSnapshot> l2 = qs.docs;
      if (l2.isNotEmpty) {
        id = l2[0].id;
        return id;
      } else {
        id = null;
        return id;
      }
    }
  }

  //send message
  void sendMessage(
      {required String id, required String message, required DateTime date}) {
    firestore.collection("chat").doc(id).collection('msg').add({
      "message": message,
      'uid': FireBaseHelper.fireBaseHelper.user!.uid,
      "datetime": date
    });
  }

  //live chat message
  Stream<QuerySnapshot<Map<String, dynamic>>> chatMessages() {
    return firestore
        .collection("chat")
        .doc(id)
        .collection('msg')
        .orderBy('datetime')
        .snapshots();
  }

  //delete my chat
  void deleteMyChat(String uid) {
    firestore.collection('chat').doc(id).collection('msg').doc(uid).delete();
  }

  //get all user whose with us
  Future<void> chatWithUser() async {
    List<ChatModel> userChat = [];
    QuerySnapshot qs = await firestore
        .collection('chat')
        .where("Userid1", isEqualTo: FireBaseHelper.fireBaseHelper.user!.uid)
        .get();
    QuerySnapshot qs2 = await firestore
        .collection('chat')
        .where("Userid2", isEqualTo: FireBaseHelper.fireBaseHelper.user!.uid)
        .get();

    List<Map> m1 = qs.docs as List<Map>;
    List<Map> m2 = qs2.docs as List<Map>;

  }
}
