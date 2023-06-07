class Food {
  String imagepath;
  String name;
  String description;
  double price;
  int count;
  bool faved;
  Food(
      {
        required this.imagepath,
        required this.name,
        required this.description,
        required this.price,
        required this.count,
        required this.faved
      }
      );
}

List<Food> foodList = [
  Food(
    imagepath: "https://console.firebase.google.com/project/foodapp-ac1d1/storage/foodapp-ac1d1.appspot.com/files/menu",
    name: "Veggie tomato mix",
    description: "description",
    price: 24.99,
    count: 1,
    faved: false,
  ),
  Food(
    imagepath: "https://console.firebase.google.com/project/foodapp-ac1d1/storage/foodapp-ac1d1.appspot.com/files/menu",
    name: "Rice and Veggies",
    description: "description",
    price: 44.99,
    count: 1,
    faved: false,
  ),
  Food(
    imagepath: "https://console.firebase.google.com/project/foodapp-ac1d1/storage/foodapp-ac1d1.appspot.com/files/menu",
    name: "Curly Pasta with peppers",
    description: "description",
    price: 50.99,
    count: 1,
    faved: false,
  ),
  Food(
    imagepath: "https://console.firebase.google.com/project/foodapp-ac1d1/storage/foodapp-ac1d1.appspot.com/files/menu",
    name: "Thai Set",
    description: "description",
    price: 76.99,
    count: 1,
    faved: false,
  ),
];