import 'package:cars_database/src/pages/car_page.dart';
import 'package:cars_database/src/pages/versions_page.dart';
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
      theme: ThemeData(
        primaryColor: Color.fromRGBO(0, 137, 123, 1),
        accentColor: Color.fromRGBO(0, 137, 123, 1),
        appBarTheme: AppBarTheme(
          color: Colors.white,
          textTheme: TextTheme(
            headline6: TextStyle(
              color: Colors.black,
              fontSize: 20.0,
              fontFamily: 'ProductSans',
              fontWeight: FontWeight.bold
            ),
          ),
          iconTheme: IconThemeData(
            color: Colors.black
          )
        ),
        fontFamily: 'ProductSans'
      ),
			initialRoute: 'home',
			routes: {
				'home': (BuildContext context) => HomePage(),
        'brands': (BuildContext context) => BrandsPage(),
        'models': (BuildContext context) => ModelsPage(),
        'versions': (BuildContext context) => VersionsPage(),
        'car': (BuildContext context) => CarPage(),
			},
		);
	}
}