import 'dart:convert';

import 'package:cars_database/src/models/car_model.dart';
import 'package:http/http.dart' as http;


class CarProvider {
  String _url = 'https://cars-database-jgeek00.firebaseio.com';

  Future fetchData(String brand, String model) async {
    final url = "$_url/cars-database/brands/$brand/models/$model.json";
    final response = await http.get(url);

    final decoded = json.decode(response.body);
    final car = CarModel.fromJson(decoded);

    return car;
  }
}