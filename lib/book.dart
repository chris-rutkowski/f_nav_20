class Book {
  final int id;
  final String title;
  final String description;

  Book({required this.id, required this.title, required this.description});

  @override
  String toString() => "Book {id=$id title=$title}";
}
