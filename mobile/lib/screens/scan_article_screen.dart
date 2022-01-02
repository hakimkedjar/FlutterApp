import 'package:cash_manager/utils/scan.dart';
import 'package:flutter/material.dart';
import 'package:cash_manager/widgets/scan_qr_code.dart';

class ScanArticleScreen extends StatelessWidget {
  const ScanArticleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ScanQrCode(callback: scanArticle),
    );
  }
}
