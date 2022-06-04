import 'package:f_nav_20/presentation/screens/book_details_screen.dart';
import 'package:f_nav_20/presentation/screens/books_screen.dart';
import 'package:flutter/material.dart';

import 'book.dart';
import 'book_route_path.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerDelegate: BookRouterDelegate(),
      routeInformationParser: BookRouteInformationParser(),
    );
  }
}

// Parses or restores the URL from/to a browser.
class BookRouteInformationParser extends RouteInformationParser<BookRoutePath> {
  @override
  Future<BookRoutePath> parseRouteInformation(RouteInformation routeInformation) async {
    debugPrint("parseRouteInformation ${routeInformation.location}");

    try {
      final segments = Uri.parse(routeInformation.location!).pathSegments;

      // Handle '/'
      if (segments.isEmpty) return BookRoutePath.home();

      if (segments.length == 2 && segments.first == 'book') {
        return BookRoutePath.details(int.parse(segments[1]));
      }
    } catch (_) {}

    return BookRoutePath.unknown();
  }

  @override
  RouteInformation? restoreRouteInformation(BookRoutePath configuration) {
    debugPrint("restoreRouteInformation $configuration");
    if (configuration.isUnknown) return const RouteInformation(location: '/404');
    if (configuration.isHomePage) return const RouteInformation(location: '/');
    if (configuration.isDetailPage) return RouteInformation(location: '/book/${configuration.id}');

    throw "couldn't restore a path!";
  }
}

class BookRouterDelegate extends RouterDelegate<BookRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<BookRoutePath> {
  Book? _book;
  var _show404 = false;

  @override
  final GlobalKey<NavigatorState> navigatorKey;

  BookRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>();

  // Restores navigator state based on path object
  @override
  BookRoutePath? get currentConfiguration {
    debugPrint("currentConfiguration _show404=$_show404 _book=$_book");

    if (_show404) return BookRoutePath.unknown();

    if (_book == null) return BookRoutePath.home();
    if (_book != null) return BookRoutePath.details(_book!.id);

    throw "couldn't restore a current configuration!";
  }

  @override
  Future<void> setNewRoutePath(BookRoutePath configuration) async {
    debugPrint("setNewRoutePath $configuration");

    if (configuration.isUnknown) {
      _book = null;
      _show404 = true;
      return;
    }

    if (configuration.isDetailPage) {
      _book = Book(
        id: configuration.id!,
        title: "Title with id ${configuration.id}",
        description: "Description with id ${configuration.id}",
      );
      _show404 = false;
      return;
    }

    if (configuration.isHomePage) {
      _book = null;
      _show404 = false;
      return;
    }
    throw "couldn't complete a setNewRoutePath";
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('build $navigatorKey');
    return Navigator(
      pages: [
        MaterialPage(
          key: const ValueKey('BooksPage'),
          child: BooksScreen(
            onTapBook: (Book book) {
              _book = book;
              notifyListeners();
            },
          ),
        ),
        if (_book != null)
          MaterialPage(
            key: const ValueKey('BookDetailsScreen'),
            child: BookDetailsScreen(book: _book!),
          ),
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) return false;

        _book = null;
        _show404 = false;
        notifyListeners();
        return true;
      },
    );
  }
}
