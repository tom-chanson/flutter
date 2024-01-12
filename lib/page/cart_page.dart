import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../bo/article.dart';
import '../bo/cart.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EPSI Shop'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Consumer<Cart>(builder: (BuildContext context, Cart cart, Widget? child) {
        return cart.listeArticles.isEmpty ?
        const EmptyCart() : ListCart(cart.listeArticles);
      },

      )
    );
  }
}

class EmptyCart extends StatelessWidget {
  const EmptyCart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Votre panier total est de:'),
              Padding(
                padding: EdgeInsets.only(right: 30),
                child: Text(
                  '0.00€',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,

                  ),
                ),
              ),
            ],
          ),
          Spacer(
            flex: 1,
          ),
          Text('Votre panier est actuellement vide'),
          Icon(Icons.image),
          Spacer(
            flex: 1,
          ),
        ],
      ),
    );
  }
}

class ListCart extends StatelessWidget {
  final List<Article> listeArticles;
  const ListCart(this.listeArticles, {super.key});

  @override
  Widget build(BuildContext context) {
    //liste des articles avec le prix total affiché en haut
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Votre panier total est de:'),
              Padding(
                padding: const EdgeInsets.only(right: 30),
                child: Text(
                  context.watch<Cart>().getTotalPrice(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const Divider(),
          Expanded(
            child: ListView.builder(
              itemCount: listeArticles.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    leading: Image.network(listeArticles[index].image, width: 80),
                    title: Text(listeArticles[index].nom),
                    subtitle: Text('${listeArticles[index].prix.toString()} €'),
                    trailing: TextButton(
                        onPressed: () {
                          context.read<Cart>().remove(listeArticles[index]);
                        },
                        child: const Text('Supprimer')),
                  ),
                );
              },
            ),
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                context.goNamed('checkout');
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.onPrimary, backgroundColor: Theme.of(context).colorScheme.primary,
              ),
              child: const Text('Valider le panier'),
            ),
          ),
        ],
      ),
    );
  }
}
