import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task1/features/news/domain/domain.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Отобразить на экране список новостей')),
      body: BlocBuilder<NewsCubit, NewsState>(
        builder: (context, state) {
          if (state is NewsLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is NewsLoaded) {
            return ListView.builder(
              itemCount: state.news.length,
              itemBuilder: (context, index) {
                final news = state.news[index];
                return ListTile(
                  title: Text(news.title),
                  subtitle: Text(
                    news.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: news.hot
                      ? Column(
                          children: [
                            Icon(Icons.star),
                            Text('горячие новости выводим в начало списка')
                          ],
                        )
                      : null,
                );
              },
            );
          } else {
            return Center(
              child: Text('Ошибка при загрузке новостей'),
            );
          }
        },
      ),
    );
  }
}
