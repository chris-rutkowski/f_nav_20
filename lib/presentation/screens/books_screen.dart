import 'package:f_nav_20/book.dart';
import 'package:flutter/material.dart';

class BooksScreen extends StatelessWidget {
  final ValueChanged<Book> onTapBook;

  BooksScreen({Key? key, required this.onTapBook}) : super(key: key);

  final books = [
    Book(id: 1, title: "Homer", description: "Amazing book about homer"),
    Book(id: 2, title: "Dolphin", description: "Amazing book about dolphin"),
    Book(id: 4, title: "Chris", description: "Amazing book about Chris"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Books'),
      ),
      body: ListView.builder(
        itemCount: books.length,
        itemBuilder: (BuildContext context, int index) {
          final book = books[index];
          return ListTile(
            title: Text(book.title),
            onTap: () => onTapBook(book),
          );
        },
      ),
    );
  }
}
