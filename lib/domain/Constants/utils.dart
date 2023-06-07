import 'package:deliveat/domain/Models/food_model.dart';


class Utils {
  static List<Food> getMockedFoods() {
    return [
      Food(
        imagepath: foodList[0].imagepath,
        name: foodList[0].name,
        description: foodList[0].description,
        price: foodList[0].price,
        count: 1,
        faved: false,
      ),
      Food(
        imagepath: foodList[1].imagepath,
        name: foodList[1].name,
        description: foodList[1].description,
        price: foodList[1].price,
        count: 1,
        faved: false,
      ),
      Food(
        imagepath: foodList[2].imagepath,
        name: foodList[2].name,
        description: foodList[2].description,
        price: foodList[2].price,
        count: 1,
        faved: false,
      ),
      Food(
        imagepath: foodList[3].imagepath,
        name: foodList[3].name,
        description: foodList[3].description,
        price: foodList[3].price,
        count: 1,
        faved: false,
      ),
    ];
  }
}