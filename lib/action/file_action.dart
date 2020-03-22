import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class FileAction {
  static void writeToFile({String dataJson, String fileName}) {
    final String path = p.join('data', fileName);
    final File file = File(path);
    file.writeAsStringSync(dataJson, mode: FileMode.writeOnly);
  }

  static void writeToFile2({String dataJson, String fileName}) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String path = directory.path + '/$fileName';
    print(path);
    final File file = File(path);
    file.writeAsStringSync(dataJson, mode: FileMode.writeOnly, flush: true);
  }

  static Future<String> readFromFile2({String fileName}) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String path = directory.path + '/$fileName';
    final File file = File(path);
    if (await file.exists()) {
      final String dataJson = file.readAsStringSync();
      print(dataJson);
      return dataJson;
    } else {
      return null;
    }
  }

  static void deleteFile({String fileName}) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String path = directory.path + '/$fileName';
    print(path);
    final File file = File(path);
    file.deleteSync();
  }

  static Future<String> readFromFile({String fileName}) async {
    final String path = p.join('data', fileName);
    final File file = File(path);
    if (await file.exists()) {
      final String dataJson = file.readAsStringSync();
      return dataJson;
    } else {
      return null;
    }
  }
}
