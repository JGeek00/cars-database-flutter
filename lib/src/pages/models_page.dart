import 'package:cars_database/src/models/brand_model.dart';
import 'package:cars_database/src/models/car_model.dart';
import 'package:cars_database/src/providers/models_provider.dart';
import 'package:flutter/material.dart';

class ModelsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final BrandModel brand = ModalRoute.of(context).settings.arguments;
   
    final ModelsProvider modelsProvider = ModelsProvider();

    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text(brand.name),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back), 
            onPressed: () {
              Navigator.pop(context);
            }
          ),
        ),
        body: Center(
          child: FutureBuilder(
            future: modelsProvider.fetchModels(brand.id),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.length == 0) {
                  return Center(
                    child: Text(
                      'Esta marca no tiene modelos',
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  );
                }
                else {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) => _createItem(context, snapshot.data[index], brand),
                  );
                }
              }
              else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _createItem(BuildContext context, data, BrandModel brand) {
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
                    padding: EdgeInsets.only(right: 30.0),
                    child: Hero(
                      tag: data.id,
                      child: FadeInImage(
                        placeholder: AssetImage('assets/no-picture.png'), 
                        image: NetworkImage(data.picture),
                        height: 100.0,
                        width: 150.0,
                        fit: BoxFit.cover,
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
          onTap: () => Navigator.pushNamed(context, 'versions', arguments: SendData(data, brand)),
        ),
      ),
    );
  }
}

class SendData {
  CarModel _car;
  BrandModel _brand;

  SendData(car, brand) {
    this._car = car;
    this._brand = brand;
  }

  get car => _car;
  get brand => _brand;
}