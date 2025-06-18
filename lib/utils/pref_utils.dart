import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefUtils {
  Future<String?> pickAndSaveOpenVpnFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );

    if (result != null && result.files.single.path != null) {
      final File selectedFile = File(result.files.single.path!);
      final appDir = await getApplicationDocumentsDirectory();

      // Copy file to app storage
      final savedFile = await selectedFile.copy('${appDir.path}/vpn_profile.ovpn');

      // Save the new path in shared preferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('ovpn_path', savedFile.path);

      return savedFile.path;
    }

    return null;
  }

  Future<String?> getSavedOpenVpnPath() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('ovpn_path');
  }

  Future<String?> loadOpenVpnContent() async {
    final path = await getSavedOpenVpnPath();
    if (path == null) return null;

    final file = File(path);
    if (!await file.exists()) return null;

    return file.readAsString();
  }
}