import 'package:flutter/material.dart';
import 'package:flutter_practice/models/article.dart';
import 'package:intl/intl.dart';

class ArticleContainer extends StatelessWidget {
  const ArticleContainer({
    super.key,
    required this.article,
  });

  final Article article;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 16,
      ),
      child: Container(
        height: 180,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        decoration: const BoxDecoration(
          color: Color(0xFF55C500),
          borderRadius: BorderRadius.all(Radius.circular(32)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 投稿日
            Text(
              DateFormat('yyyy/MM/dd').format(article.createdAt),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
            // タイトル
            Text(
              article.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            // タグ
            Text(
              '#${article.tags.join(' #')}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontStyle: FontStyle.italic,
              ),
            ),
            // いいね、投稿者
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // いいね数
                Column(
                  children: [
                    const Icon(
                      Icons.favorite,
                      color: Colors.white,
                    ),
                    Text(
                      article.likesCount.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                // 投稿者
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CircleAvatar(
                      radius: 26,
                      backgroundImage:
                          NetworkImage(article.user.profileImageUrl),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      article.user.id,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
