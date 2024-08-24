import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:main/ViewModel/Grid/GridStateModel.dart';

// Export the grid state to a JSON string
String exportGridState(GridModel gridModel) {
  return jsonEncode(gridModel.toJson());
}

// Import the grid state from a JSON string
GridModel importGridState(String jsonString) {
  return GridModel.fromJson(jsonDecode(jsonString));
}

// Save the grid state to a JSON file
Future<void> saveToFile(GridModel gridModel) async {
  // Use FilePicker to get a path to save the file
  final savePath = await FilePicker.platform.saveFile(
    dialogTitle: 'Please select a location to save your grid state file',
    fileName: 'grid_state.json',
  );

  if (savePath != null) {
    try {
      // Ensure the file has a .json extension
      final file =
          File(savePath.endsWith('.json') ? savePath : '$savePath.json');
      final gridJson = exportGridState(gridModel);
      await file.writeAsString(gridJson);
      print('File saved successfully at: $savePath');
    } catch (e) {
      print('Error saving file: $e');
    }
  } else {
    print('Save operation was canceled.');
  }
}

// Load the grid state from a JSON file
Future<GridModel?> loadFromFile() async {
  try {
    // Use FilePicker to select a JSON file
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['json'], // Ensure only JSON files are selectable
    );

    if (result != null) {
      final file = File(result.files.single.path!);
      final gridJsonString = await file.readAsString();
      return importGridState(gridJsonString);
    } else {
      print('File selection was canceled.');
    }
  } catch (e) {
    print('Error loading file: $e');
  }

  return null;
}
