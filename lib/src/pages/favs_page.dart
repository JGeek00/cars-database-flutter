import 'package:flutter/material.dart';

class FavsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Favoritos'),
          centerTitle: true,
          brightness: Brightness.light,
        ),
        body: Text('Favs'),
      ),
    );
  }
}