import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

import '../controller/file_profile_controller.dart';


class FileProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FileProfileController>(() => FileProfileController());
  }
}