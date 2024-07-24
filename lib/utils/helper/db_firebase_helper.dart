import 'package:chat_app/screen/profile/model/profile_model.dart';
import 'package:chat_app/utils/helper/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DbFirebaseHelPer {
  static DbFirebaseHelPer dbFirebaseHelPer = DbFirebaseHelPer._();

  DbFirebaseHelPer._();

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String? userUid;

  String getUserUid() {
    return userUid = FireBaseHelper.fireBaseHelper.user!.uid;
  }

  Future<void> userProfile(ProfileModel m1) async {
    await firestore.collection('user').doc(userUid).set(m1.modelToMap());
  }

  Future<ProfileModel> currentUser() async {
    DocumentSnapshot ds = await firestore.collection('user').doc(userUid).get();
    Map model = ds.data() as Map;
    ProfileModel data = ProfileModel.mapToModel(model);
    return data;
  }

  Future<void> getAllUser() async {
    List<ProfileModel>? listData;
    QuerySnapshot qs = await firestore.collection('user').get();
    List<QueryDocumentSnapshot> document = qs.docs;

    for (var x in document) {
      ProfileModel model = x.reference as ProfileModel;
      model.id = x.id;
      listData!.add(model);
    }
  }
}
