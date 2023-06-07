import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart';

class OnlyItem{
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future<String> downloadURLL(String imageName) async{
    String downloadURL=await storage.ref('menu/$imageName').getDownloadURL();
    return downloadURL;

  }
}