import 'package:brew_crew/screens/home/brew_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brew_crew/models/brew.dart';

class BrewList extends StatefulWidget {
  const BrewList({super.key});

  @override
  State<BrewList> createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {
    final brews = Provider.of<List<Brew>?>(context);
    //brews can be null so its index can not be unconditionally accessed, so we use if-else condition to return empty container if brews is null
    return brews != null
        ? ListView.builder(
            itemCount: brews?.length,
            itemBuilder: (context, index) {
              return BrewTile(brew: brews[index]);
            })
        : Container();
  }
}
