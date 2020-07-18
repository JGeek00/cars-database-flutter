import 'package:cars_database/src/providers/brands_provider.dart';
import 'package:flutter/material.dart';

class BrandsPage extends StatelessWidget {
  final BrandsProvider brandsProvider = BrandsProvider();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Marcas'),
          centerTitle: true,
          brightness: Brightness.light,
        ),
        body: FutureBuilder(
          future: brandsProvider.fetchBrands(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.length == 0) {
                return Center(
                  child: Text('No hay marcas'),
                );
              }
              else {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, index) => _createItem(context, snapshot.data[index]),
                );
              }
            }
            else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        )
      ),
    );
  }

  _createItem(BuildContext context, data) {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: Material(
        borderRadius: BorderRadius.circular(5.0),
        elevation: 5.0,
        child: InkWell(
          borderRadius: BorderRadius.circular(5.0),
          child: Container(
            child: Row(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: Container(
                    padding: EdgeInsets.only(right: 30.0, top: 10.0, bottom: 10.0),
                    child: Hero(
                      tag: data.id,
                      child: FadeInImage(
                        placeholder: AssetImage('assets/no-picture.png'), 
                        image: NetworkImage(data.logo),
                        height: 50.0,
                        width: 100.0,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                Text(
                  data.name,
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold
                  ),
                )
              ],
            ),
          ),
          onTap: () => Navigator.pushNamed(context, 'models', arguments: data),
        ),
      ),
    );
  }
}
