import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../bo/cart.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  int methodSelect = -1;

  void updateMethodSelect(int value) {
    setState(() {
      methodSelect = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    const economy = 0.01;
    num priceTva = context.watch<Cart>().getTotalPriceNum() / 100 * 20;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Finalisation de la commande'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              CommandSummary(economy: economy, priceTva: priceTva),
              const Padding(
                padding: EdgeInsets.only(top: 16.0),
                child: Delivery(),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: MethodPayment(onMethodSelect: updateMethodSelect),
              ),
              const Spacer(),
              const Text(
                "En cliquant sur \"Confirmer l'achat\", vous acceptez les conditions de vente de l'EPSI Shop International. Besoin d'aide ? Désolé on peut rien faire.",
                style: TextStyle(fontSize: 12),
              ),
              const Text(
                "En poursuivant, vous acceptez les Conditions d'utilisation du fournisseur de paiement CoffeeDis",
                style: TextStyle(fontSize: 12),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => {
                    //snackbar
                    if (methodSelect != -1)
                      {
                        // sendRequest(
                        //   105,
                        //     "8 rue des ouvertures de portes, 93204 CORBEAUX",
                        //     "PayPal"),
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('Achat confirmé'),
                          duration: Duration(seconds: 1),
                        ))
                      }
                  },
                  style: methodSelect != -1
                      ? ElevatedButton.styleFrom(
                          foregroundColor:
                              Theme.of(context).colorScheme.onPrimary,
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                        )
                      : ElevatedButton.styleFrom(
                          foregroundColor:
                              Theme.of(context).colorScheme.primary,
                          backgroundColor:
                              Theme.of(context).colorScheme.onPrimary,
                        ),
                  child: methodSelect != -1
                      ? const Text("Confirmer l'achat")
                      : Text("Sélectionner une méthode de paiement"),
                ),
              )
            ],
          ),
        ));
  }
}

class MethodPayment extends StatefulWidget {
  final Function(int) onMethodSelect;

  const MethodPayment({
    super.key,
    required this.onMethodSelect,
  });

  @override
  State<MethodPayment> createState() => _MethodPaymentState();
}

class _MethodPaymentState extends State<MethodPayment> {
  List<IconData> iconList = [
    FontAwesomeIcons.ccApplePay,
    FontAwesomeIcons.ccVisa,
    FontAwesomeIcons.ccMastercard,
    FontAwesomeIcons.ccPaypal
  ];
  int methodSelect = -1;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Méthode de paiement",
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        Row(
          children: [
            for (var i = 0; i < iconList.length; i++)
              IconCard(
                icon: iconList[i],
                selected: methodSelect == i,
                onSelect: () {
                  setState(() {
                    methodSelect = i;
                    widget.onMethodSelect(i);
                  });
                },
              ),
          ],
        ),
      ],
    );
  }
}

class Delivery extends StatelessWidget {
  const Delivery({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Adresse de livraison",
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: Theme.of(context).colorScheme.outline),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Michel Le Poney",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          "8 rue des ouvertures de portes",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Text(
                          "93204 CORBEAUX",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ]),
                  const Spacer(),
                  const Icon(Icons.arrow_forward_ios),
                ],
              ),
            )),
      ],
    );
  }
}

class CommandSummary extends StatelessWidget {
  const CommandSummary({
    super.key,
    required this.economy,
    required this.priceTva,
  });

  final double economy;
  final num priceTva;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Theme.of(context).colorScheme.outline),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Récapitulatif de votre commande",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              children: [
                Text(
                  "Sous-total:",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const Spacer(),
                Text(
                  "${context.watch<Cart>().getTotalPriceNum()}€",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Text(
                  "Vous économisez: $economy€",
                  //title medium and green color
                  style: const TextStyle(fontSize: 16, color: Colors.green),
                ),
                const Spacer(),
                Text("-$economy€",
                    style: const TextStyle(fontSize: 16, color: Colors.green)),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Text(
                  "TVA:",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const Spacer(),
                Text(
                  "$priceTva€",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                const Text(
                  "TOTAL",
                  //en gras
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                Text(
                  "${context.watch<Cart>().getTotalPriceNum() + priceTva}€",
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class IconCard extends StatelessWidget {
  final IconData icon;
  final bool selected;
  final VoidCallback onSelect;

  const IconCard(
      {super.key,
      required this.icon,
      this.selected = false,
      required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: selected
            ? Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side:
                      BorderSide(color: Theme.of(context).colorScheme.primary),
                ),
                child: Badge(
                  //badge rond avec une check
                  label: const Text("✔"),
                  textStyle: const TextStyle(color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Icon(icon, size: 50),
                  ),
                ))
            : GestureDetector(
                onTap: onSelect,
                child: Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                        color: Theme.of(context).colorScheme.outline),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Icon(icon, size: 50),
                  ),
                ),
              ));
  }
}

Future<void> sendRequest(num toal, String adress, String paymentMethod) async {
  final response = await http.post(
    Uri.parse('http://ptsv3.com/t/EPSISHOPC2/'),
    body: {
      'total': toal,
      'adress': adress,
      'paymentMethod': paymentMethod,
    },
  );
}
