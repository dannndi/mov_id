import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';

enum PickType {
  Camera,
  Galerry,
}

class BaseServices {
  //Image Picker
  static Future<File> pickImage(PickType type) async {
    var image = await ImagePicker().getImage(
      source:
          (type == PickType.Camera) ? ImageSource.camera : ImageSource.gallery,
    );
    if (image != null) {
      return File(image.path);
    }
    return null;
  }

  //Upload Image
  static Future<String> uploadImageToFireStore(File file) async {
    String fileName = basename(file.path);
    var ref = FirebaseStorage.instance.ref().child(fileName);
    var task = ref.putFile(file);
    var onComplete = await task.onComplete;
    return await onComplete.ref.getDownloadURL();
  }
}
