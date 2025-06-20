import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:openvpn_client/add_profile/controller/manual_profile_controller.dart';

class ManualProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ManualProfileController>(() => ManualProfileController());
  }
}