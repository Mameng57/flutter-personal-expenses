import 'dart:io';
import 'package:path_provider/path_provider.dart';

class LocalStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;

    return File("$path/data.json");
  }

  Future<String> readFile() async {
    try {
      final file = await _localFile;
      final contents = await file.readAsString();

      return contents;
    }
    catch(exceptions) {
      return "";
    }
  }

  Future<File> writeFile(String json) async {
    final file = await _localFile;

    return file.writeAsString(json);
  }
}