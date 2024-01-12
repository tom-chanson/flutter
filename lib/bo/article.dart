class Article{
  final String nom;
  final String image;
  final String description;
  final num prix;
  final String categorie;

  //créer un constructeur avec
  //paramètres nommés et required
  //nom, image, description, prix, categorie
  Article({
    required this.nom,
    required this.image,
    required this.description,
    required this.prix,
    required this.categorie,
  });


  //créer une méthode pour afficher le prix en euro
  getPrixEuro() => '$prix €';

  Map<String, dynamic> toMap() {
    return {
      'title': nom,
      'image': image,
      'description': description,
      'price': prix,
      'categorie': categorie,
    };
  }

  factory Article.fromMap(Map<String, dynamic> map) {
    return Article(
      nom: map['title'] as String,
      image: map['image'] as String,
      description: map['description'] as String,
      prix: map['price'] as num,
      categorie: map['category'] as String,
    );
  }
}

void main() {
  //créer une liste d'articles
  //print un article avec son nom et son prix
  final List<Article> listeArticle = [
    Article(nom: "article 1", image: "image 1", description: "description 1", prix: 10.5, categorie: "categorie 1"),
    Article(nom: "article 2", image: "image 2", description: "description 2", prix: 10, categorie: "categorie 2"),
  ];

  for (var element in listeArticle) {
    print("${element.nom} à ${element.getPrixEuro()}");
  }
}