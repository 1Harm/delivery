import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cart/flutter_cart.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:deliveat/presentation/Pages/ProgressPage.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:deliveat/domain/Models/user_model.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // final controller = TextEditingController();
  final black = Colors.black;
  final yellow = Colors.yellow;
  final customAppBarColor = const Color(0xFF2C2C33);
  final white1 = Colors.white;
  late DatabaseReference _dbref;
  String databasejson = "";
  int countvalue = 0;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _dbref = FirebaseDatabase.instance.ref();

    _dbref.child('cart').onValue.listen((event) {
      setState(() {
        countvalue = event.snapshot.value as int;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var cart = FlutterCart();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2C2C33),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Text(
            countvalue.toString() + '' + databasejson,
            style: const TextStyle(fontSize: 24),
          ),
        ],
      ),
    );
  }

// getcart() {
//   _dbref.once().then((DatabaseEvent databaseEvent) {
//     print('read once-' + databaseEvent.snapshot.value.toString());
//     setState(() {
//       databasejson = databaseEvent.snapshot.value.toString();
//       jsonDecode(databaseEvent as String);
//     });
//   });
// }
}