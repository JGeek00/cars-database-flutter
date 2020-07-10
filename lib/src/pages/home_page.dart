import 'package:cars_database/src/pages/brands_page.dart';
import 'package:cars_database/src/pages/favs_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
	int page = 0;

	@override
	Widget build(BuildContext context) {
		return Container(
			child: Scaffold(
				body: _renderPage(),
				bottomNavigationBar: BottomNavigationBar(
					currentIndex: page,
					items: <BottomNavigationBarItem>[
						BottomNavigationBarItem(
							icon: Icon(Icons.directions_car),
							title: Text('Coches')
						),
						BottomNavigationBarItem(
							icon: Icon(Icons.star),
							title: Text('Favoritos'),
						),
					],
					onTap: (value) {
						setState(() {
						  page = value;
						});
					},
				),
			),
		);
	}

  _renderPage() {
    switch (page) {
        case 0:
        return BrandsPage();
        
      case 1:
        return FavsPage();
    }
  }
}