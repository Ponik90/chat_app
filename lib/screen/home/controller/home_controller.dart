import 'package:chat_app/screen/profile/model/profile_model.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxList<ProfileModel> userList = <ProfileModel>[].obs;
}
