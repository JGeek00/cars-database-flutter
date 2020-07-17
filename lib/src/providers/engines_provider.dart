import 'dart:convert';

import 'package:cars_database/src/models/engine_model.dart';
import 'package:http/http.dart' as http;

class EnginesProvider {
  String _url = "https://cars-database-jgeek00.firebaseio.com";

  Future fetchEngines(brandId, modelId, versionId) async {
    final url = "$_url/cars-database/brands/$brandId/models/$modelId/versions/$versionId/engines.json";
    final response = await http.get(url);

    final Map<String, dynamic> decoded = json.decode(response.body);
    final List<EngineModel> enginesList = List();
    
    if (decoded != null) {
      decoded.forEach((id, element) {
        final engine = EngineModel.fromJson(element);
        enginesList.add(engine);
      });
    }

    return enginesList;
  }
}