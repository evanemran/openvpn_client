import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:openvpn_client/add_profile/controller/profile_tab_controller.dart';
import '../controller/add_profile_controller.dart';

class AddProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddProfileController>(() => AddProfileController());
    Get.lazyPut<ProfileTabController>(() => ProfileTabController());
  }
}