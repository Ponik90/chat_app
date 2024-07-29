import 'package:chat_app/screen/profile/model/profile_model.dart';
import 'package:chat_app/utils/helper/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DbFirebaseHelPer {
  static DbFirebaseHelPer dbFirebaseHelPer = DbFirebaseHelPer._();

  DbFirebaseHelPer._();

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String? userUid;

  void getUserUid() {
    userUid = FireBaseHelper.fireBaseHelper.user!.uid;
  }

  Future<void> userProfile(ProfileModel m1) async {
    getUserUid();

    await firestore.collection('user').doc(userUid).set(m1.modelToMap());
  }

  Future<ProfileModel> currentUser() async {
    getUserUid();
    DocumentSnapshot ds = await firestore.collection('user').doc(userUid).get();
    Map? model = ds.data() as Map?;
    ProfileModel data = ProfileModel.mapToModel(
        model ?? {"name": "", "email": "", "phone": ""});
    return data;
  }

  Future<List<ProfileModel>> getAllUser() async {
    List<ProfileModel> listData = [];
    QuerySnapshot qs = await firestore.collection('user').get();
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

  Future<void> checkChatId(
      String myId, String user2id, DateTime data, String message) async {
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
        await firestore
            .collection('chat')
            .add({'Userid1': myId, 'Userid2': user2id});
        chatMessage(id: myId, message: message, date: DateTime.now());
      } else {
        String id = l2[0].id;
        chatMessage(id: myId, message: message, date: DateTime.now());
      }
    } else {
      String id = l1[0].id;
      chatMessage(id: myId, message: message, date: DateTime.now());
    }
  }

  void chatMessage(
      {required String id, required String message, required DateTime date}) {
    firestore
        .collection('chat')
        .add({"message": message, 'uid': id, "datetime": date});
  }
}
