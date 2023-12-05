import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return SearchBar(
      hintText: "Search",
      textStyle: MaterialStatePropertyAll(TextStyle(fontSize: 17)),
      elevation: MaterialStatePropertyAll(0),
      leading: Icon(Icons.search_rounded),
      padding: MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 15)),
      backgroundColor: MaterialStatePropertyAll(Colors.grey[200]),
    );
  }
}
