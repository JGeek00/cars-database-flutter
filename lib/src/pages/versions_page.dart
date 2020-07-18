import 'dart:ui';

import 'package:cars_database/src/models/brand_model.dart';
import 'package:cars_database/src/models/car_model.dart';
import 'package:cars_database/src/models/version_model.dart';
import 'package:cars_database/src/providers/car_provider.dart';
import 'package:cars_database/src/providers/versions_provider.dart';
import 'package:flutter/material.dart';

class VersionsPage extends StatelessWidget {  
  final CarProvider carProvider = new CarProvider();
  final VersionsProvider versionsProvider = new VersionsProvider();

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context).settings.arguments;

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
      child: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            _headingImage(context, data, height),
            _versions(data, width),
          ],
        ),
      ),
    );
  }

  Widget _headingImage(BuildContext context, data, height) {
    return SliverAppBar(
      elevation: 5.0,
      expandedHeight: 300.0,
      floating: false,
      pinned: true,
      snap: false,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      brightness: Brightness.light,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          "${data.brand.name} ${data.car.name}",
          style: TextStyle(
            color: Colors.black
          ),
        ),
        centerTitle: true,
        collapseMode: CollapseMode.pin,
        background: Column(
          children: <Widget>[
            Container(
              height: height*0.3,
              width: double.infinity,
              child: Hero(
                tag: data.car.id,
                child:FadeInImage(
                  placeholder: AssetImage('assets/no-picture.png'), 
                  image: NetworkImage(data.car.picture),
                  fadeInDuration: Duration(milliseconds: 150),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _versions(data, width) {
    return Container(
      child: FutureBuilder(
        future: versionsProvider.fetchVersions(data.brand.id, data.car.id),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.length == 0) {
              return SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Text(
                      'Este coche no tiene versiones.',
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ]
                ),
              );
            }
            else {
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    if (index == snapshot.data.length) {
                      return SizedBox(height: 15.0);
                    }
                    else {
                      return _createItem(context, snapshot.data[index], data, width);
                    }
                  },
                  childCount: snapshot.data.length+1,
                ),
              );
            }
          }
          else {
            return SliverList(
              delegate: SliverChildListDelegate(
                [
                  Center(
                    child: Container(
                      padding: EdgeInsets.only(top: 200.0),
                      child: CircularProgressIndicator()
                    )
                  )
                ]
              )
            );
          }
        }
      ),
    );
  }

  Widget _createItem(BuildContext context, data, generalData, width) {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: Material(
        borderRadius: BorderRadius.circular(5.0),
        elevation: 5.0,
        child: InkWell(
          borderRadius: BorderRadius.circular(5.0),
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: 150.0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5.0), topLeft: Radius.circular(5.0)),
                    child: Container(
                      child: Hero(
                        tag: data.id,
                        child: FadeInImage(
                          placeholder: AssetImage('assets/no-picture.png'), 
                          image: NetworkImage(data.picture),
                          width: 150.0,
                          height: 100.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: width-170.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        data.model,
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(height: 30.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Año: ${data.year}"),
                          Text('   |   '),
                          Text("Carrocería: ${data.bodywork}")
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          onTap: () => Navigator.pushNamed(context, 'car', arguments: SendData(generalData.car, generalData.brand, data)),
        ),
      ),
    );
  }
}

class SendData {
  CarModel _car;
  BrandModel _brand;
  VersionModel _version;

  SendData(car, brand, version) {
    this._car = car;
    this._brand = brand;
    this._version = version;
  }

  get car => _car;
  get brand => _brand;
  get version => _version;
}