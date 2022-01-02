import 'package:cash_manager/constants/articles.dart';
import 'package:cash_manager/models/article.dart';
import 'package:cash_manager/services/api_service.dart';
import 'package:cash_manager/utils/snack_bar.dart';
import 'package:cash_manager/widgets/article_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Article>>(
        future: _getArticles(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int i) {
                  return ArticleCard(article: snapshot.data![i]);
                });
          } else if (snapshot.hasError) {
            return Center(child: Text('${snapshot.error}'));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: "Cart",
            onPressed: () => Navigator.pushNamed(context, '/cart'),
            child: const Icon(Icons.shopping_basket_outlined),
          ),
          const SizedBox(width: 25),
          FloatingActionButton(
            heroTag: "Scan Article",
            onPressed: () => Navigator.pushNamed(context, '/scan/article'),
            child: const Icon(Icons.qr_code_scanner_outlined),
          )
        ],
      ),
    );
  }

  Future<List<Article>> _getArticles() async {
    try {
      List<Article> articles = [];

      Map<String, dynamic> body = await API.get("/article/retrieve-all");

      for (Map<String, dynamic> article in body['articles']) {
        articles.add(Article.fromJson(article));
      }
      return articles;
    } catch (e) {

      showErrorMessage(context: context);
      rethrow;
    }
  }
}
