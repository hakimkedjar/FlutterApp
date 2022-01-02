import 'dart:convert';
import 'package:cash_manager/models/credit_card.dart';
import 'package:cash_manager/utils/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';

class ScanNFC extends StatefulWidget {
  const ScanNFC({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ScanNFCState();
}

class ScanNFCState extends State<ScanNFC> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) => _tagRead());
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text("Waiting for NFC",
            style: TextStyle(fontWeight: FontWeight.bold)));
  }

  @override
  void dispose() {
    NfcManager.instance.stopSession();
    super.dispose();
  }

  void _tagRead() {
    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      try {
        Ndef? ndef = Ndef.from(tag);
        NdefRecord record = ndef!.cachedMessage!.records.first;
        String content = ascii
            .decode(record.payload)
            .substring(3); // Remove language prefix "en"
        Navigator.pushReplacementNamed(context, '/payement',
            arguments: CreditCard.fromJson(jsonDecode(content)));
      } catch (e) {
        showErrorMessage(context: context, content: e.toString());
        Navigator.popUntil(context, ModalRoute.withName('/cart'));
      }
    });
  }
}
