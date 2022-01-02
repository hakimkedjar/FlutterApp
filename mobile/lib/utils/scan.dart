import 'dart:convert';

import 'package:cash_manager/models/article.dart';
import 'package:cash_manager/models/credit_card.dart';
import 'package:cash_manager/provider/cart.dart';
import 'package:cash_manager/services/api_service.dart';
import 'package:cash_manager/utils/snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

void scanArticle(BuildContext context, scanData) async {
  try {
    Map<String, dynamic> res =
        await API.get("/article/retrieve/${scanData.code!}");
    Article article = Article.fromJson(res['article']);
    Provider.of<Cart>(context, listen: false).add(article);
    showSuccessfulMessage(
        context: context, content: "${article.title} was added !");
    Navigator.popUntil(context, ModalRoute.withName('/home'));
  } catch (e) {
    showErrorMessage(context: context, content: e.toString());
    Navigator.popUntil(context, ModalRoute.withName('/home'));
  }
}

void scanPayement(BuildContext context, scanData) {
  try {
    CreditCard creditCard = CreditCard.fromJson(jsonDecode(scanData.code!));
    Navigator.pushReplacementNamed(context, '/payement', arguments: creditCard);
  } catch (e) {
    showErrorMessage(context: context, content: e.toString());
    Navigator.popUntil(context, ModalRoute.withName('/cart'));
  }
}
