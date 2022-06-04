class BookRoutePath {
  final int? id;
  final bool isUnknown;

  BookRoutePath({required this.id, required this.isUnknown});

  BookRoutePath.home()
      : id = null,
        isUnknown = false;

  BookRoutePath.details(this.id) : isUnknown = false;

  BookRoutePath.unknown()
      : id = null,
        isUnknown = true;

  bool get isHomePage => id == null;
  bool get isDetailPage => id != null;

  @override
  String toString() => "BookRoutePath {id=$id isUnknown=$isUnknown}";
}
