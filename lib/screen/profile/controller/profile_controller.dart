import 'package:chat_app/screen/profile/model/profile_model.dart';
import 'package:chat_app/utils/helper/db_firebase_helper.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  Rx<ProfileModel> model = ProfileModel().obs;

  Future<void> getUserDetail() async {
    ProfileModel data = await DbFirebaseHelPer.dbFirebaseHelPer.currentUser();
    model.value = data;
  }
}
