import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:openvpn_client/utils/date_utils.dart';
import 'package:openvpn_client/utils/pref_utils.dart';
import 'package:openvpn_client/utils/toast_utils.dart';
import 'package:openvpn_flutter/openvpn_flutter.dart';

import '../widget/servers_sheet.dart';

class VpnController extends GetxController {

  OpenVPN? _vpn;
  var log = "Logs:\n".obs;
  var status = Rxn<VpnStatus>();
  var server = "Unknown".obs;
  var openVpnContent = "".obs;
  var isConnected = false.obs;

  var connectedOn = "N/A".obs;
  var duration = "Disconnected".obs;
  var byteIn = "0.00".obs;
  var byteOut = "0.00".obs;
  var packetsIn = "0.00".obs;
  var packetsOut = "0.00".obs;

  var allServers = <String>['🏡 Home', '🏢 Office', '🖥️ Workstation'].obs;
  var selectedServer = "".obs;

  @override
  void onInit() {
    super.onInit();
    initVpnProfile();
    _vpn = OpenVPN(
      onVpnStatusChanged: (data) {
        status.value = data;
        parseStatus(data!);
      },
      onVpnStageChanged: (vpnStage, stage) {
        if (vpnStage == VPNStage.connected) {
          ToastUtils.showToast("Connected!!");
        }
        else if (vpnStage == VPNStage.disconnected) {
          ToastUtils.showToast("Disconnected VPN!!");
        }
        else if (vpnStage == VPNStage.error) {
          ToastUtils.showToast("Error Occurred!");
        }
        log.value += "Stage: $stage\n";
      },
    );
  }

  void toggleConnection() {
    if(isConnected.value) {
      disconnect();
      isConnected.value = false;
    }
    else {
      connect(openVpnContent.value);
      isConnected.value = true;
    }
  }

  void updateSelectedServer(String server) {
    selectedServer.value = server;
  }

  void showServerSelector(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return ServerBottomSheet(
          servers: ['🏡 Home', '🏢 Office', '🖥️ Workstation'],
        );
      },
    );
  }

  void initVpnProfile() async {
    final content = await PrefUtils().loadOpenVpnContent();
    if (content != null) {
      openVpnContent.value = content;
      server.value = extractRemoteAddress(content)??"Unknown";
    }
  }

  Future<void> selectOpenVpnFile() async {

    final path = await PrefUtils().pickAndSaveOpenVpnFile();

    if (path != null) {
      final file = File(path);
      final config = await file.readAsString();
      openVpnContent.value = config;
      toggleConnection();
    }
  }

  String? extractRemoteAddress(String config) {
    final lines = config.split('\n');
    for (var line in lines) {
      if (line.trim().startsWith('remote ')) {
        final parts = line.trim().split(' ');
        return parts.length > 1 ? parts[1] : null;
      }
    }
    return null;
  }

  Future<void> connect(String config) async {

    try {
      duration.value = "Connecting...";
      final connectedServer = extractRemoteAddress(config);
      server.value = connectedServer ?? "Private";
      log.value = 'Loaded .ovpn for: $server\n';

      await _vpn?.initialize(
        groupIdentifier: "",
        providerBundleIdentifier: "",
        localizedDescription: "Flutter VPN",
      );
      _vpn?.connect(config, "vpn_profile", username: "", password: "");
    }
    catch (e) {
      ToastUtils.showToast("Error Occurred!");
    }
  }

  void disconnect() {
    _vpn?.disconnect();
    log.value += 'Disconnected.\n';
    resetValues();
  }

  void parseStatus(VpnStatus data) {
    connectedOn.value = AppDateUtils.formatVpnTime(data.connectedOn??DateTime.now());
    duration.value = data.duration!;
    byteIn.value = (double.parse(data.byteIn!)/(1024*1024)).toStringAsFixed(2);
    byteOut.value = (double.parse(data.byteOut!)/(1024*1024)).toStringAsFixed(2);
    packetsIn.value = data.packetsIn!;
    packetsOut.value = data.packetsOut!;
  }

  void resetValues() {
    duration.value = "Disconnected";
    connectedOn.value = "";
    byteIn.value = "0.00";
    byteOut.value = "0.00";
  }

}