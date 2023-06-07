import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:deliveat/data/service/category_item_provider.dart';
import 'package:deliveat/domain/Models/carousel_item.dart';
import 'package:deliveat/domain/Models/category_item.dart';
import 'package:deliveat/domain/Constants/utils.dart';
import 'package:deliveat/domain/Models/food_model.dart';
import 'package:deliveat/bloc/auth_bloc/auth_bloc.dart';
import 'package:deliveat/bloc/auth_bloc/auth_event.dart';
import 'RestaurantPage.dart';
import 'package:deliveat/data/service/storage.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  final User? user;

  const HomePage({Key? key, required this.user}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final user = FirebaseAuth.instance.currentUser;
  final CarouselItemsProvider _carouselItemsProvider = CarouselItemsProvider();
  final CategoryItemsProvider _categoryItemsProvider = CategoryItemsProvider();

  List<Food> foods = Utils.getMockedFoods();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Row(
            children: [
              const Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 5, 280, 0),
                child: CircleAvatar(
                  radius: 30,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.exit_to_app),
                onPressed: () {
                  BlocProvider.of<AuthBloc>(context).add(
                    AuthLoggedOut(),
                  );
                },
              )
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30, bottom: 40),
            child: Center(
              child: Text(
               AppLocalizations.of(context)!.helloUser(user?.email ?? ''),
                  style: const TextStyle(
                  fontSize: 24,
                ),
              ),
            ),
          ),
           Row(
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 10, 0, 0),
                child: Text(
                  AppLocalizations.of(context)!.category,
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900),
                ),
              )
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(5, 20, 5, 0),
              child: FutureBuilder<List<CategoryItem>>(
                future: _categoryItemsProvider.getCategoryItems(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      return GridView.builder(
                        gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: 1,
                        ),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          final item = snapshot.data![index];
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: Material(
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const Menu(),
                                    ),
                                  );
                                },
                                child: Image.network(
                                  item.imageUrl,
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return  Center(
                        child: Text(AppLocalizations.of(context)!.notfound),
                      );
                    }
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          ),
           Row(
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 10, 0, 0),
                child: Text(
                  AppLocalizations.of(context)!.restaraunts,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              )
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FutureBuilder<List<CarouselItem>>(
                future: _carouselItemsProvider.getCarouselItems(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      return CarouselSlider(
                        items: snapshot.data!
                            .map(
                              (item) => ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Menu(),
                                  ),
                                );
                              },
                              child: Image.network(
                                item.imageUrl,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        )
                            .toList(),
                        options: CarouselOptions(
                          autoPlay: false,
                          enlargeCenterPage: true,
                          aspectRatio: 16 / 7,
                          enableInfiniteScroll: true,
                        ),
                      );
                    } else {
                      return Center(
                        child: Text(
                          AppLocalizations.of(context)!.noCarouselItemsFound,
                        ),
                      );
                    }
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
