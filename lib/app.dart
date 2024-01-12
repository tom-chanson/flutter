import 'package:epsi_shop/page/about_us_page.dart';
import 'package:epsi_shop/page/cart_page.dart';
import 'package:epsi_shop/page/checkout_page.dart';
import 'package:epsi_shop/page/detail_article.dart';
import 'package:epsi_shop/page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'bo/article.dart';


final _article = [
  {
    "nom": "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops",
    "image": "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg",
    "price": 22.3
  },
  {
    "nom": "Mens Casual Premium Slim Fit T-Shirts ",
    "image":
    "https://fakestoreapi.com/img/71li-ujtlUL._AC_UX679_.jpg",
    "price": 9.85
  }
];

final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (_, __) => const Homepage(),
      routes: [
        GoRoute(
          path: 'cart',
          name: 'cart',
          builder: (_, __) => const CartPage(),
          routes: [
            GoRoute(
              path: 'checkout',
              name: 'checkout',
              builder: (_, __) => const CheckoutPage(),
            ),
          ],
        ),
        GoRoute(
          path: 'aboutus',
          name: 'aboutus',
          builder: (_, __) => AboutUsPage(),
        ),
        GoRoute(
          path: 'detail',
          name: 'detail',
          builder: (_, state) => DetailArticle(article: state.extra as Article),

        )
      ],
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      routerConfig: _router,
    );
  }
}
