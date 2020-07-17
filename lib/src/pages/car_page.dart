import 'package:flutter/material.dart';
import 'package:cars_database/src/providers/engines_provider.dart';
import 'package:cars_database/src/custom_icons.dart';

class CarPage extends StatelessWidget {
  final EnginesProvider enginesProvider = new EnginesProvider();

  @override
  Widget build(BuildContext context) {
    final car = ModalRoute.of(context).settings.arguments;
    
    return Container(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          body: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return[
                _headingImage(context, car),
              ];
            },
            body: _pageBody(car),
          ),
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
      // title: Text("${data.brand.name} ${data.car.name} ${data.version.model}"),
      centerTitle: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        background: Column(
          children: <Widget>[
            Container(
              height: 250.0,
              width: double.infinity,
              child: Hero(
                tag: data.version.id,
                child: FadeInImage(
                  placeholder: AssetImage('assets/loading.gif'), 
                  image: NetworkImage(data.version.picture),
                  fadeInDuration: Duration(milliseconds: 150),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
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
    );
  }

  Widget _pageBody(data) {
    return TabBarView(
      children: [
        _info(data),
        _engines(data)
      ]
    );
  }

  Widget _info(data) {
    return Container(
      child: ListView(
        children: <Widget>[
          _topRow(data)
        ],
      ),
    );
  }

  Widget _topRow(data) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0.0, 1.0), //(x,y)
            blurRadius: 6.0,
          ),
        ],
        color: Colors.white
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(bottom: 5.0),
                  child: Text(
                    'Marca',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0
                    ),
                  ),
                ),
                Text(data.brand.name)
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey
            ),
            width: 1.0,
            height: 30.0,
          ),
          Container(
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(bottom: 5.0),
                  child: Text(
                    'Modelo',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0
                    ),
                  ),
                ),
                Text(data.car.name)
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey
            ),
            width: 1.0,
            height: 30.0,
          ),
          Container(
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(bottom: 5.0),
                  child: Text(
                    'Carrocería',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0
                    ),
                  ),
                ),
                Text(data.version.bodywork)
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey
            ),
            width: 1.0,
            height: 30.0,
          ),
          Container(
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(bottom: 5.0),
                  child: Text(
                    'Año',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0
                    ),
                  ),
                ),
                Text(data.version.year.toString())
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _size(data) {
        return Container(
      margin: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0.0, 1.0), //(x,y)
            blurRadius: 6.0,
          ),
        ],
        color: Colors.white
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(bottom: 5.0),
                  child: Text(
                    'Ancho',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0
                    ),
                  ),
                ),
                Text("${data.version.width} m")
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey
            ),
            width: 1.0,
            height: 30.0,
          ),
          Container(
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(bottom: 5.0),
                  child: Text(
                    'Largo',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0
                    ),
                  ),
                ),
                Text("${data.version.length} m")
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey
            ),
            width: 1.0,
            height: 30.0,
          ),
          Container(
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(bottom: 5.0),
                  child: Text(
                    'Alto',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0
                    ),
                  ),
                ),
                Text("${data.version.height} m")
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey
            ),
            width: 1.0,
            height: 30.0,
          ),
          Container(
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(bottom: 5.0),
                  child: Text(
                    'Peso',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0
                    ),
                  ),
                ),
                Text("${data.version.weight} Kg")
              ],
            ),
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
        return AlertDialog(
          title: Text(engine.name),
          content: Column(
            mainAxisSize: MainAxisSize.min,
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
          actions: <Widget>[
            FlatButton(
              child: Text(
                "Cerrar",
                style: TextStyle(
                  color: Theme.of(context).primaryColor
                ),
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        );
      }
    );
  }
}