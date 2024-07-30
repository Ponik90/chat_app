import 'package:chat_app/screen/profile/model/profile_model.dart';
import 'package:chat_app/utils/helper/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DbFirebaseHelPer {
  static DbFirebaseHelPer dbFirebaseHelPer = DbFirebaseHelPer._();

  DbFirebaseHelPer._();

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String? userUid;

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
  Future<List<ProfileModel>> getAllUser() async {
    List<ProfileModel> listData = [];
    QuerySnapshot qs = await firestore
        .collection('user')
        .where(FireBaseHelper.fireBaseHelper.user!.uid, isNotEqualTo: userUid)
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
    QuerySnapshot qs = await firestore
        .collection('chat')
        .where('Userid1', isEqualTo: myId)
        .where('userid2', isEqualTo: user2id)
        .get();
    List<QueryDocumentSnapshot> l1 = qs.docs;
    if (l1.isEmpty) {
      QuerySnapshot qs = await firestore
          .collection('chat')
          .where('Userid2', isEqualTo: myId)
          .where('userid1', isEqualTo: user2id)
          .get();
      List<QueryDocumentSnapshot> l2 = qs.docs;
      if (l2.isEmpty) {
        //create new chat
        DocumentReference dr = await firestore
            .collection('chat')
            .add({'Userid1': myId, 'Userid2': user2id});

        String otherUserId = dr.id;
        sendMessage(id: otherUserId, message: message, date: DateTime.now());
      } else {
        String id = l2[0].id;
        sendMessage(id: id, message: message, date: DateTime.now());
      }
    } else {
      String id = l1[0].id;
      sendMessage(id: id, message: message, date: DateTime.now());
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
  void chatMessages() {}
}
