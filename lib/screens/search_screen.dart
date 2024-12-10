import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_practice/models/article.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Article> articles = []; // 検索結果を格納するリスト

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Qiita Search'),
        ),
        body: Column(
          children: [
            // 検索ボックス
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 36,
              ),
              child: TextField(
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
                decoration: const InputDecoration(
                  hintText: '検索ワードを入力してください',
                ),
                onSubmitted: (String value) async {
                  final results = await searchQiita(value);
                  setState(() => articles = results);
                },
              ),
            ),
            // 検索結果一覧
          ],
        ));
  }

  Future<List<Article>> searchQiita(String keyword) async {
    // 1. http通信に必要なデータを準備
    final uri = Uri.https('qiita.com', '/api/v2/items', {
      'query': 'title:$keyword',
      'per_page': '10',
    });

    final String token = dotenv.env['QIITA_API_TOKEN'] ?? '';

    // 2. Qiita APIにリクエストを送信
    final http.Response response = await http.get(
      uri,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    // 3. 戻り値をArticleのリストに変換
    // 4. Articleのリストを返す
    if (response.statusCode == 200) {
      final List<dynamic> body = jsonDecode(response.body);
      return body.map((json) => Article.fromJson(json)).toList();
    } else {
      return [];
    }
  }
}
