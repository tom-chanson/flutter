import 'package:epsi_shop/bo/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app.dart';

void main() {
  //On fournit une instance de Cart à toute notre application
  runApp(ChangeNotifierProvider(create: (_) => Cart() ,
  child: const MyApp()));
}
