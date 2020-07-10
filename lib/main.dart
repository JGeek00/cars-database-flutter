import 'package:cars_database/src/pages/car_page.dart';
import 'package:flutter/material.dart';

import 'package:cars_database/src/pages/brands_page.dart';
import 'package:cars_database/src/pages/models_page.dart';
import 'package:cars_database/src/pages/home_page.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return MaterialApp(
			title: 'Cars Database',
			debugShowCheckedModeBanner: false,
			initialRoute: 'home',
			routes: {
				'home': (BuildContext context) => HomePage(),
        'brands': (BuildContext context) => BrandsPage(),
        'models': (BuildContext context) => ModelsPage(),
        'car': (BuildContext context) => CarPage()
			},
		);
	}
}