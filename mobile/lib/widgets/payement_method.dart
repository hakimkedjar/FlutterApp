import 'package:flutter/material.dart';

class PayementMethod extends StatelessWidget {
  const PayementMethod({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
              icon: const Icon(Icons.qr_code_outlined),
              onPressed: () =>
                  Navigator.pushReplacementNamed(context, '/scan/qr/payement')),
          const SizedBox(width: 25),
          IconButton(
              icon: const Icon(Icons.nfc_outlined),
              onPressed: () => Navigator.pushReplacementNamed(
                  context, '/scan/nfc/payement')),
        ],
      ),
    );
  }
}
