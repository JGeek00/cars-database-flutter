import 'dart:convert';

import 'package:flutter/cupertino.dart';

VersionModel versionModelFromJson(String str) => VersionModel.fromJson(json.decode(str));

String versionModelToJson(VersionModel data) => json.encode(data.toJson());

class VersionModel {
    VersionModel({
        this.model,
        this.picture,
        this.year,
        this.bodywork
    });

    String id;
    String model;
    String picture;
    int year;
    String bodywork;

    factory VersionModel.fromJson(Map json) => VersionModel(
        model: json["model"].toString(),
        picture: json["picture"],
        year: json["year"],
        bodywork: json["bodywork"]
    );

    Map<String, dynamic> toJson() => {
        "model": model.toString(),
        "picture": picture,
        "year": year,
        "bodywork": bodywork
    };
}
