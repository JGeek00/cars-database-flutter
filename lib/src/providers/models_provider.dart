import 'dart:convert';

import 'package:cars_database/src/models/car_model.dart';
import 'package:http/http.dart' as http;

class ModelsProvider {
  String _url = "https://cars-database-jgeek00.firebaseio.com";

  Future fetchModels(brandId) async {
    final url = "$_url/cars-database/brands/$brandId/models.json";
    final response = await http.get(url);

    final Map<String, dynamic> decoded = json.decode(response.body);
    final List<CarModel> modelsList = List();
    
    if (decoded != null) {
      decoded.forEach((id, element) {
        final car = CarModel.fromJson(element);
        modelsList.add(car);
      });
    }

    return modelsList;
  }
}