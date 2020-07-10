import 'dart:convert';

import 'package:cars_database/src/models/brand_model.dart';
import 'package:http/http.dart' as http;

class BrandsProvider {
  String _url = "https://cars-database-jgeek00.firebaseio.com";

  Future fetchBrands() async {
    final url = "$_url/cars-database.json";
    final response = await http.get(url);

    final Map<String, dynamic> decoded = json.decode(response.body);
    final List<BrandModel> brandsList = List();

    decoded['brands'].forEach((id, element) {
      final brand = BrandModel.fromJson(element);
      brand.id = id;
      brandsList.add(brand);
    });
    
    return brandsList;
  }
}