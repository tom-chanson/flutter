import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../bo/article.dart';
import '../bo/cart.dart';

class DetailArticle extends StatelessWidget {
  Article article;

  DetailArticle({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var intId = 1;
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text(article.nom)),
          backgroundColor: Colors.blue,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(child: Image.network(article.image, height: 200)),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(article.nom, style: Theme.of(context).textTheme.displaySmall,
              textAlign: TextAlign.start,),
            ),
            Text(article.description, style: const TextStyle(fontSize: 20)),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Prix: ${article.prix}€',
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.end,
                ),
              ),
            //catégorie
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Catégorie: ${article.categorie}',
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            ),
            const Spacer(),
            //bouton ajouter au panier rectangulaire bleu avec texte blanc et qui prend toute la largeur
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                onPressed: () {
                  context.read<Cart>().add(article);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Article ajouté au panier'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                ),
                child: const Text('AJOUTER AU PANIER', style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ));
  }
}
