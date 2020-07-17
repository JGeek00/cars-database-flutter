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

    return Container(
      child: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            _headingImage(context, data),
            _versions(data)
          ],
        ),
      ),
    );
  }

  Widget _headingImage(BuildContext context, data) {
    return SliverAppBar(
      elevation: 5.0,
      expandedHeight: 300.0,
      floating: false,
      pinned: true,
      snap: false,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
              height: 250.0,
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

  // Widget _header(data) {
  //   return Container(
  //     padding: EdgeInsets.symmetric(vertical: 20.0),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: <Widget>[
  //         FadeInImage(
  //           placeholder: AssetImage('assets/loading.gif'), 
  //           image: NetworkImage(data.brand.logo),
  //           width: 100.0,
  //           height: 50.0,
  //           fit: BoxFit.contain,
  //         ),
  //         SizedBox(width: 10.0),
  //         Container(
  //           child: Text(
  //             data.car.name,
  //             style: TextStyle(
  //               fontWeight: FontWeight.bold,
  //               fontSize: 20.0
  //             ),
  //           ),
  //         ),
  //         SizedBox(width: 25.0),
  //       ],
  //     ),
  //   );
  // }

  Widget _versions(data) {
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
                  (context, index) => _createItem(context, snapshot.data[index], data),
                  childCount: snapshot.data.length,
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

  Widget _createItem(BuildContext context, data, generalData) {
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
                    borderRadius: BorderRadius.circular(5.0),
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
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  width: 250.0,
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