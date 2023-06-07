import 'package:firebase_storage/firebase_storage.dart';
import 'package:deliveat/domain/Models/category_item.dart';

class CategoryItemsProvider {
  final FirebaseStorage _storage =
  FirebaseStorage.instanceFor(bucket: 'gs://foodapp-ac1d1.appspot.com/');

  Future<List<CategoryItem>> getCategoryItems() async {
    final ListResult result = await _storage.ref().child('category').listAll();

    final List<CategoryItem> categoryItems = [];

    for (final ref in result.items) {
      final downloadUrl = await ref.getDownloadURL();
      final metadata = await ref.getMetadata();

      final categoryItem = CategoryItem(
        imageUrl: downloadUrl,
        caption: metadata.name,
      );

      categoryItems.add(categoryItem);
    }
    return categoryItems;
  }
}
