import 'dart:convert';

import 'package:cars_database/src/models/version_model.dart';
import 'package:http/http.dart' as http;

class VersionsProvider {
  String _url = "https://cars-database-jgeek00.firebaseio.com";

  Future fetchVersions(brandId, modelId) async {
    final url = "$_url/cars-database/brands/$brandId/models/$modelId/versions.json";
    final response = await http.get(url);

    final Map<String, dynamic> decoded = json.decode(response.body);
    final List<VersionModel> versionsList = List();
    
    if (decoded != null) {
      decoded.forEach((id, element) {
        final car = VersionModel.fromJson(element);
        car.id = id;
        versionsList.add(car);
      });
    }

    return [null, ...versionsList];
  }
}