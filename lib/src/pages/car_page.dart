import 'package:flutter/material.dart';

import 'package:cars_database/src/models/car_model.dart';

class CarPage extends StatelessWidget {  
  @override
  Widget build(BuildContext context) {
    final CarModel car = ModalRoute.of(context).settings.arguments;
    return Container(
      child: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            _headingImage(car),
          ],
        ),
      ),
    );
  }

  Widget _headingImage(CarModel car) {
    return SliverAppBar(
      elevation: 5.0,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Hero(
          tag: car.id,
          child: FadeInImage(
            placeholder: AssetImage('assets/loading.gif'), 
            image: NetworkImage(car.picture),
            fadeInDuration: Duration(milliseconds: 150),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}