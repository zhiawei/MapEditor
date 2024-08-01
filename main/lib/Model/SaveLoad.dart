import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:main/ViewModel/Grid/GridStateModel.dart';

String exportGridState(GridModel gridModel) {
  return jsonEncode(gridModel.toJson());
}

GridModel importGridState(String jsonString) {
  return GridModel.fromJson(jsonDecode(jsonString));
}

Future<void> saveToFile(GridModel gridModel) async {
  final directory = await FilePicker.platform.saveFile();

  if (directory != null) {
    final file = File(directory);
    final gridJson = exportGridState(gridModel);
    await file.writeAsString(gridJson);
  }
}

Future<GridModel?> loadFromFile() async {
  final result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['txt'],
  );

  if (result != null) {
    final file = File(result.files.single.path!);
    final gridJsonString = await file.readAsString();
    return importGridState(gridJsonString);
  }
  return null;
}
