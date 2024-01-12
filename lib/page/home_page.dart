
import 'dart:convert';

import 'package:epsi_shop/bo/article.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart';

import '../bo/cart.dart';


class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Article> listeArcticle = [
      Article(
        nom: "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops",
        image: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg",
        prix: 22.3,
        description: "Veste de randonnée",
        categorie: "Veste",
      ),
      Article(
        nom: "Mens Casual Premium Slim Fit T-Shirts ",
        image: "https://fakestoreapi.com/img/71li-ujtlUL._AC_UX679_.jpg",
        prix: 9.85,
        description: "T-Shirt",
        categorie: "T-Shirt",
      )
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.all(16),
          child: Center(
            child: Text('E-Commerce')
          ),
        ),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            onPressed: () {
              context.goNamed('cart');
            },
            icon: Badge(label: Text("${context.watch<Cart>().listeArticles.length}"),child: const Icon(Icons.shopping_cart),
          ),
          ),
          IconButton(onPressed: () {
            context.goNamed('aboutus');
          },
              icon: const Icon(Icons.info_outlined))
        ],
      ),
      body:
          FutureBuilder<List<Article>>(future: fetchListProducts(), builder: (context, snapshot)
          => switch(snapshot.connectionState) {
            ConnectionState.none => const Text('Aucune connexion'),
            ConnectionState.waiting => const Center(child: CircularProgressIndicator()),
            ConnectionState.done when (snapshot.hasData) => ListArticles(listeArcticle: snapshot.data!),
          _ => const Text('Erreur de connexion'),
          },
          ),
      );
  }

  Future<List<Article>> fetchListProducts() async {
    final response = await get(Uri.parse('https://fakestoreapi.com/products'));
    if (response.statusCode == 200 && response.body.isNotEmpty) {
      final body = jsonDecode(response.body) as List<dynamic>;
      return body.map((e) => Article.fromMap(e as Map<String, dynamic>)).toList();
    } else {
      throw Exception('Requête invalide');
    }
  }
}

class ListArticles extends StatelessWidget {
  const ListArticles({
    super.key,
    required this.listeArcticle,
  });

  final List<Article> listeArcticle;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: listeArcticle.length,
        itemBuilder: (context, index) {
      return Card(
        child: ListTile(
          leading: Image.network(listeArcticle[index].image, width: 80),
          title: GestureDetector(
            onTap: () {
              context.goNamed('detail', extra: listeArcticle[index]);
            },
            child: Text(listeArcticle[index].nom),
          ),
          subtitle: Text('${listeArcticle[index].prix.toString()} €'),
          trailing: IconButton(
              onPressed: () {
                context.read<Cart>().add(listeArcticle[index]);
              },
              icon: const Icon(Icons.add_shopping_cart),
          ),
        ),
      );
    });
  }
}
