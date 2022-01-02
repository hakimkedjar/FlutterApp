import 'package:cash_manager/models/credit_card.dart';
import 'package:cash_manager/provider/cart.dart';
import 'package:cash_manager/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class PayementScreen extends StatelessWidget {
  const PayementScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<Cart>();
    CreditCard card = ModalRoute.of(context)!.settings.arguments as CreditCard;
    return Scaffold(
      body: FutureBuilder<String>(
        future: _payement(card.id, cart.total),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const Center(child: Text("Payment accepted !"));
          } else if (snapshot.hasError) {
            return const Center(child: Text('Payment refused'));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Future<String> _payement(int code, int balance) async {
    try {
      await API.post("/terminal/pay", {"code": "$code", "balance": "$balance"});
      return "_";
    } catch (e) {
      rethrow;
    }
  }
}
