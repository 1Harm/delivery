import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:deliveat/domain/Models/carousel_item.dart';

class MenuItemsProvider  {
  final FirebaseStorage _storage =
  FirebaseStorage.instanceFor(bucket: 'gs://foodapp-ac1d1.appspot.com/');

  Future<List<CarouselItem>> getMenuItems() async {
    final ListResult result = await _storage.ref().child('menu').listAll();


    final List<CarouselItem> carouselItems = [];

    for (final ref in result.items) {
      final downloadUrl = await ref.getDownloadURL();
      final metadata = await ref.getMetadata();

      final carouselItem = CarouselItem(
        imageUrl: downloadUrl,
        caption: metadata.name,
      );

      carouselItems.add(carouselItem);
    }
    return carouselItems;
  }
}
