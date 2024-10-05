import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ImagePickerService{
static Future imagePicker(BuildContext context,ImageSource source) async {
  try {
    // final image = await ImagePicker().pickImage(source: source);
    PickedFile ?pickedFile = await ImagePicker().getImage(source: source);
    if (pickedFile == null) return;
    bool size = checkFileSize(pickedFile.path, context);
    return size? File(pickedFile.path):null;
  } on PlatformException catch (e) {
    print('Failed to pick image$e');
  }
}


 static bool checkFileSize(path, context) {
    // file = null;
    var fileSizeLimit = 2;
    File f = new File(path);
    var s = f.lengthSync();
    print(s); // returns in bytes
    var fileSizeInKB = s / 1024;
    var fileSizeInMB = fileSizeInKB / 1024;
    print("size..$fileSizeInMB");
    if (fileSizeInMB > fileSizeLimit) {
      EasyLoading.showToast('File size less than 2MB');
      return false;
    } else {}
    print("file can be selected");
    return true;
  }

}
