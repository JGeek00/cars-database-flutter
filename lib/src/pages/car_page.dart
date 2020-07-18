import 'package:flutter/material.dart';
import 'package:cars_database/src/providers/engines_provider.dart';
import 'package:cars_database/src/custom_icons.dart';

class CarPage extends StatelessWidget {
  final EnginesProvider enginesProvider = new EnginesProvider();

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context).settings.arguments;

    final width = MediaQuery.of(context).size.width;
    
    return Container(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: _title(data),
            centerTitle: true,
            brightness: Brightness.light,
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.star_border), 
                onPressed: () {}
              )
            ],
            bottom: TabBar(
              labelColor: Theme.of(context).primaryColor,
              indicatorColor: Colors.teal,
              tabs: [
                Tab(
                  icon: Icon(Icons.info),
                  text: 'General',
                ),
                Tab(
                  icon: Icon(CustomIcons.engine),
                  text: 'Motores',
                ),
              ]
            ),
          ),
          body: TabBarView(
            children: [
              _info(data, width),
              _engines(data)
            ]
          )
        ),
      ),
    );
  }

  Widget _title(data) {
    return Text("${data.brand.name} ${data.car.name} ${data.version.model}");
  }

  Widget _info(data, width) {
    return Container(
      child: ListView(
        children: <Widget>[
          _picture(data, width),
          _general(data),
          _size(data)
        ],
      ),
    );
  }

  Widget _picture(data, width) {
    return Container(
      padding: EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Hero(
            tag: data.version.id,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: FadeInImage(
                placeholder: AssetImage('assets/no-picture.png'), 
                image: NetworkImage(data.version.picture),
                fit: BoxFit.contain,
                width: width-30.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _general(data) {
    return Container(
      padding: EdgeInsets.only(top: 30.0),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Información del modelo',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 15.0),
          ListTile(
            title: Text('Marca'),
            trailing: Text(data.brand.name),
          ),
          Divider(),
          ListTile(
            title: Text('Modelo'),
            trailing: Text(data.car.name),
          ),
          Divider(),
          ListTile(
            title: Text('Carrocería'),
            trailing: Text(data.version.bodywork),
          ),
          Divider(),
          ListTile(
            title: Text('Año'),
            trailing: Text(data.version.year.toString()),
          ),
        ],
      ),
    );
  }

  Widget _size(data) {
    return Container(
      padding: EdgeInsets.only(top: 40.0),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Tamaño y peso',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 15.0),
          ListTile(
            title: Text('Anchura'),
            trailing: Text("${data.version.width.toString()} m"),
          ),
          Divider(),
          ListTile(
            title: Text('Altura'),
            trailing: Text("${data.version.height.toString()} m"),
          ),
          Divider(),
          ListTile(
            title: Text('Longitud'),
            trailing: Text("${data.version.length.toString()} m"),
          ),
          Divider(),
          ListTile(
            title: Text('Peso'),
            trailing: Text("${data.version.weight.toString()} Kg"),
          ),
        ],
      ),
    );
  }

  Widget _engines(data) {
    // print(data.version.engines);
    return FutureBuilder(
      future: enginesProvider.fetchEngines(data.brand.id, data.car.id, data.version.id),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data != null) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, index) => _engineItem(context, snapshot.data[index]),
            );
          }
          else {
            return Container(
              child: Center(
                child: Text('Esta versión no tiene motores disponibles.')
              ),
            );
          }
        }
        else {
          return Container(
            child: Center(
              child: CircularProgressIndicator()
            )
          );
        }
      }
    );
  }

  Widget _engineItem(context, engine) {
    return ListTile(
      title: Text(engine.name),
      subtitle: Text(engine.fuel),
      trailing: Text(
        "${engine.power} CV",
        style: TextStyle(
          fontSize: 15.0
        ),
      ),
      onTap: () => _displayEngineDialog(context, engine),
    );
  }

  void _displayEngineDialog(BuildContext context, engine) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 20.0, bottom: 10.0),
                  child: Text(
                    engine.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        title: Text('Combustible'),
                        trailing: Text("${engine.fuel}"),
                      ),
                      Divider(),
                      ListTile(
                        title: Text('Potencia'),
                        trailing: Text("${engine.power.toString()} CV"),
                      ),
                      Divider(),
                      ListTile(
                        title: Text('Par motor'),
                        trailing: Text("${engine.torque.toString()} nm"),
                      ),
                      Divider(),
                      ListTile(
                        title: Text('Consumo'),
                        trailing: Text("${engine.consumption.toString()} L/100 Km"),
                      ),
                      Divider(),
                      ListTile(
                        title: Text('Caja de cambios'),
                        trailing: Text("${engine.gearboxType}"),
                      ),
                      Divider(),
                      ListTile(
                        title: Text('Nº de velocidades'),
                        trailing: Text("${engine.gearboxGears}"),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      FlatButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          'Cerrar',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor
                          ),
                        )
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      }
    );
  }
}