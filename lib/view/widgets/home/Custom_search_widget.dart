import 'package:flutter/material.dart';
import 'package:pharmageddon_mobile/print.dart';

class CustomSearch extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    printme.cyan(query);
    printme.magenta(query.isEmpty);
    if (query.isEmpty) return const Text('data');
    return const SizedBox();
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
        appBarTheme: const AppBarTheme(
          color: Colors.purpleAccent,
        ),
        scaffoldBackgroundColor: Colors.pink,
        inputDecorationTheme:
            const InputDecorationTheme(border: InputBorder.none));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const SizedBox();
  }
}
