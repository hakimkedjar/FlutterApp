import 'package:cash_manager/models/article.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:cash_manager/provider/cart.dart';

class ArticleCard extends StatefulWidget {
  const ArticleCard({Key? key, required this.article, this.inCart = false})
      : super(key: key);
  final Article article;
  final bool inCart;
  @override
  _ArticleCardState createState() => _ArticleCardState();
}

class _ArticleCardState extends State<ArticleCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 100,
        child: Card(
          child: Row(
            children: [
              const SizedBox(width: 20),
              const Icon(
                Icons.fastfood,
                size: 50,
              ),
              const SizedBox(width: 25),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.article.title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15)),
                  Text(widget.article.description),
                  const SizedBox(height: 5),
                  Text('${widget.article.price} \$',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16))
                ],
              ),
              Expanded(
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: widget.inCart
                          ? IconButton(
                              onPressed: () =>
                                  Provider.of<Cart>(context, listen: false)
                                      .remove(widget.article),
                              icon: const Icon(Icons.remove))
                          : IconButton(
                              onPressed: () =>
                                  Provider.of<Cart>(context, listen: false)
                                      .add(widget.article), icon: const Icon(Icons.add)))),
              const SizedBox(width: 20)
            ],
          ),
        ),
      ),
    );
  }
}
