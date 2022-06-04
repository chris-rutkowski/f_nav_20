import 'package:f_nav_20/book.dart';
import 'package:flutter/material.dart';

class BookDetailsScreen extends StatelessWidget {
  final Book book;
  const BookDetailsScreen({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book details'),
      ),
      body: Column(
        children: [
          Text(book.title),
          Text(book.description),
        ],
      ),
    );
  }
}
