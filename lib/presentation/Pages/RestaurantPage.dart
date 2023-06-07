import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:deliveat/presentation/category_details/details_page.dart';
import 'package:deliveat/domain/Models/food_model.dart';
import 'package:deliveat/domain/Constants/utils.dart';

import 'package:deliveat/data/service/menu_item_provider.dart';
import 'package:deliveat/domain/Models/carousel_item.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> with SingleTickerProviderStateMixin {
  List<Food> foods = Utils.getMockedFoods();

  final MenuItemsProvider _menuItemsProvider = MenuItemsProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 100),
              child: FutureBuilder<List<CarouselItem>>(
                future: _menuItemsProvider.getMenuItems(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      return CarouselSlider(
                        items: snapshot.data!
                            .map(
                              (item) => ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Material(
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => DetailsPage(
                                            selectedFood: foods[1],
                                          ),
                                        ),
                                      );
                                    },
                                    child: Image.network(
                                      item.imageUrl,
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                        options: CarouselOptions(
                          autoPlay: false,
                          enlargeCenterPage: true,
                          aspectRatio:3/4,
                          enableInfiniteScroll: true,
                        ),
                      );
                    } else {
                      return  Center(
                        child: Text(AppLocalizations.of(context)!.noCarouselItemsFound),
                      );
                    }
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
