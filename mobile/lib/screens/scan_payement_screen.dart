import 'package:cash_manager/utils/scan.dart';
import 'package:cash_manager/widgets/scan_nfc.dart';
import 'package:flutter/material.dart';
import 'package:cash_manager/widgets/scan_qr_code.dart';

class ScanPayementScreen extends StatelessWidget {
  const ScanPayementScreen({Key? key, this.nfc = false}) : super(key: key);
  final bool nfc;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: nfc ? const ScanNFC() : const ScanQrCode(callback: scanPayement),
    );
  }
}
