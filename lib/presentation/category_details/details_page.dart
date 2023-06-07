import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:deliveat/bloc/repositories/user_repository.dart';
import 'package:deliveat/data/service/only_item_service.dart';
import 'package:deliveat/domain/Models/food_model.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:deliveat/presentation/Pages/Auth/login/login_screen.dart';
import 'package:deliveat/presentation/Pages/Auth/register/register_screen.dart';
import 'package:deliveat/presentation/Pages/CartPage.dart';
import 'package:deliveat/data/service/only_item_service.dart';

class DetailsPage extends StatefulWidget {

  Food selectedFood;

  DetailsPage({Key? key, required this.selectedFood}) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final database = FirebaseDatabase.instance.ref();
  bool faved = false;


  @override
  Widget build(BuildContext context) {
    final ref = database.child('cart');
    final Size size = MediaQuery.of(context).size;
    final favRef = database.child('favourites');
    final OnlyItem storage = OnlyItem();

    return Scaffold(
      backgroundColor: const Color(0xFF2C2C33),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2C2C33),
        elevation: 0.0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 0),
            child: IconButton(
              onPressed: () async {
                try {
                  final nextRef = <String, dynamic>{
                    'name': widget.selectedFood.name,
                    'price': widget.selectedFood.price,
                  };
                  String? key;
                  database
                      .child('favourites')
                      .orderByChild('name')
                      .equalTo(widget.selectedFood.name)
                      .onChildAdded
                      .listen((event) {
                    setState(() {
                      key = event.snapshot.key.toString();
                    });
                  }, onError: (Object o) {
                    print(o.toString());
                  });
                  try {
                    favRef
                        .orderByChild('name')
                        .equalTo(widget.selectedFood.name)
                        .once()
                        .then((value) => {
                      if (value.snapshot.exists)
                        {
                          database
                              .child('favourites')
                              .child('1')
                              .remove(),
                          setState(() {
                            widget.selectedFood.faved = false;
                          }),
                        }
                      else
                        {
                          database
                              .child('favourites')
                              .child('4')
                              .set(nextRef),
                          setState(() {
                            widget.selectedFood.faved = true;
                          }),
                        }
                    });
                  } catch (e) {
                    print(e.toString());
                  }
                } catch (e) {
                  print(e.toString());
                }
              },
              icon: ImageIcon(
                widget.selectedFood.faved
                    ? const AssetImage("assets/images/favicon.png")
                    : const AssetImage("assets/images/notfav_icon.png"),
              ),
            ),
          ),
        ],
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 20,
              width: 20,
              child: IconButton(
                // Your drawer Icon
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const ImageIcon(
                  AssetImage("assets/images/appbar_back.png"),
                  color: Colors.black,
                ),
              ),
            ),
            // Your widgets here
          ],
        ),
      ), //CustomAppBar(context),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              child: Column(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FutureBuilder(
                          future: storage.downloadURLL('griby.jpg'),
                          builder: (BuildContext context,
                              AsyncSnapshot<String> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done &&
                                snapshot.hasData) {
                              return SizedBox(
                                width: size.width,
                                height: 300,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: Image.network(
                                    snapshot.data!,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            }
                            if (snapshot.connectionState ==
                                ConnectionState.waiting ||
                                snapshot.hasData) {
                              return const CircularProgressIndicator();
                            }
                            return Container();
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    widget.selectedFood.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 28,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    widget.selectedFood.price.toString(),
                    style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 22,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Column(
                children: [

                  const Row(
                    children: [
                      Text(
                        "Return policy",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 17,
                          color: Color(0xffBAD1FF),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                    child: Text(
                      "All our foods are double checked before leaving our stores so by any case you found a spoiled food please contact our hotline immediately.",
                      style: TextStyle(
                        color: Color(0xffBAD1FF),
                        fontSize: 15,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: 40,
                    width: 400,
                    decoration: BoxDecoration(
                      color: const Color(0xffff0000),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: TextButton(
                      onPressed: () async {

                        if (FirebaseAuth.instance.currentUser!.displayName!.isNotEmpty) {
                          try {
                            final nextRef = <String, dynamic>{
                              'name': widget.selectedFood.name,
                              'price': widget.selectedFood.price,
                              'imagepath': widget.selectedFood.imagepath,
                              'count': 1,
                            };
                            String? key;
                            database
                                .child('cart')
                                .orderByChild('name')
                                .equalTo(widget.selectedFood.name)
                                .onChildAdded
                                .listen((event) {
                              setState(() {
                                key = event.snapshot.key.toString();
                              });
                            }, onError: (Object o) {
                              print(o.toString());
                            });

                            try {
                              ref
                                  .orderByChild('name')
                                  .equalTo(widget.selectedFood.name)
                                  .once()
                                  .then((value) =>
                              {
                                if (value.snapshot.exists)
                                  {
                                    database
                                        .child('cart')
                                        .child(key!)
                                        .child('count')
                                        .set(widget.selectedFood.count++)
                                  }
                                else
                                  {
                                    database
                                        .child('cart')
                                        .child('4')
                                        .set(nextRef)
                                  }
                              });
                            } catch (e) {
                              print(e.toString());
                            }
                          } catch (e) {
                            print('You got an error $e');
                          }
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CartPage(),
                            ),
                          );
                        } else{
                          showAlertDialog(context);
                        }
                      },
                      child: const Text(
                        "Add to chart",
                        style: TextStyle(color: Colors.black, fontSize: 17),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

showAlertDialog(BuildContext context) {
  // Create button
  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );


  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Error"),
    content: Text("You need to be authorized"),
    actions: [
      okButton
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}