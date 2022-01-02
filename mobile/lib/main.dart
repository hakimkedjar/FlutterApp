import 'package:cash_manager/screens/payement_screen.dart';
import 'package:cash_manager/screens/scan_payement_screen.dart';
import 'package:flutter/material.dart'; 
import 'package:cash_manager/screens/home_screen.dart';
import 'package:cash_manager/screens/cart_screen.dart';
import 'package:cash_manager/utils/local_storage.dart';
import 'package:cash_manager/screens/scan_article_screen.dart';
import 'package:cash_manager/screens/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:cash_manager/provider/cart.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorage.init();
  runApp(
    ChangeNotifierProvider<Cart>(
      create: (_) => Cart(),
      child: const App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cash Manager',
      routes: {
        '/': (_) => const LoginScreen(),
        '/home': (_) => const HomeScreen(),
        '/cart': (_) => const CartScreen(),
        '/scan/article': (_) => const ScanArticleScreen(),
        '/scan/qr/payement': (_) => const ScanPayementScreen(),
        '/scan/nfc/payement': (_) => const ScanPayementScreen(nfc: true),
        '/payement': (_) => const PayementScreen(),
      },

    );
  }
}
