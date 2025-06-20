import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/pref_utils.dart';

class ProfileTabController extends GetxController with GetSingleTickerProviderStateMixin {
  late TabController tabController;

  var selectedTabNumber = 0.obs;

  @override
  void onInit() {
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      if (!tabController.indexIsChanging) {
        selectedTabNumber.value = tabController.index;
      }
    });
    super.onInit();
  }


  Future<String?> selectOpenVpnFile() async {

    final path = await PrefUtils().pickAndSaveOpenVpnFile();

    if (path != null) {
      final file = File(path);
      final config = await file.readAsString();
      return config;
    }
    else {
      return null;
    }
  }


  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
