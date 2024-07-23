import 'package:chat_app/screen/profile/model/profile_model.dart';
import 'package:chat_app/utils/helper/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DbFirebaseHelPer {
  static DbFirebaseHelPer dbFirebaseHelPer = DbFirebaseHelPer._();

  DbFirebaseHelPer._();

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String? userUid;

  String getUserUid()
  {
    return userUid = FireBaseHelper.fireBaseHelper.user!.uid;
  }

  Future<void> userProfile(ProfileModel m1) async {
   await firestore.collection('user').doc(userUid).set({
      'name' : m1.name,
      'email': m1.email,
      'phone': m1.phone
    });
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserData()
  {
    return  firestore.collection('user').doc(userUid).get();
  }
}
