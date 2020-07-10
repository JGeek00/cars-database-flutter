import 'package:cars_database/src/models/brand_model.dart';
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
                    itemBuilder: (context, index) => _createItem(context, snapshot.data[index]),
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

  Widget _createItem(BuildContext context, data) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5.0),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            )
          ]
        ),
        child: Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: Container(
                padding: EdgeInsets.only(right: 30.0),
                child: Hero(
                  tag: data.id,
                  child: FadeInImage(
                    placeholder: AssetImage('assets/loading.gif'), 
                    image: NetworkImage(data.picture),
                    height: 100.0,
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
      onTap: () => Navigator.pushNamed(context, 'car', arguments: data),
    );
  }
}