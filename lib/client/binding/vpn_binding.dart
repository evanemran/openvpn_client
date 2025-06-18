import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:openvpn_client/client/controller/vpn_controller.dart';

class VpnBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VpnController>(() => VpnController());
  }
}