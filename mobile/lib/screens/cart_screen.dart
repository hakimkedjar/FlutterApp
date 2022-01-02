import 'package:cash_manager/widgets/payement_method.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cash_manager/provider/cart.dart';
import 'package:cash_manager/widgets/article_card.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  CartScreenState createState() => CartScreenState();
}

class CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cart = context.watch<Cart>();
    return Scaffold(
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: cart.articles.length,
                  itemBuilder: (BuildContext context, int i) {
                    return ArticleCard(article: cart.articles[i], inCart: true);
                  }),
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(50, 25, 0, 25),
                    child: Text(
                      "Total: ${cart.total}",
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    )))
          ],
        ),
        floatingActionButton: FloatingActionButton(
          heroTag: "Pay",
          onPressed: () => showDialog(
            context: context,
            builder: (BuildContext context) => const PayementMethod(),
          ),
          child: const Icon(Icons.payment),
        ));
  }
}
