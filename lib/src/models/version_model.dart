import 'dart:convert';

VersionModel versionModelFromJson(String str) => VersionModel.fromJson(json.decode(str));

String versionModelToJson(VersionModel data) => json.encode(data.toJson());

class VersionModel {
    VersionModel({
        this.id,
        this.bodywork,
        this.engines,
        this.height,
        this.length,
        this.model,
        this.picture,
        this.weight,
        this.width,
        this.year,
    });

    String id;
    String bodywork;
    Map<String, Engine> engines;
    double height;
    double length;
    String model;
    String picture;
    int weight;
    double width;
    int year;

    factory VersionModel.fromJson(Map<String, dynamic> json) => VersionModel(
        bodywork: json["bodywork"],
        engines: Map.from(json["engines"]).map((k, v) => MapEntry<String, Engine>(k, Engine.fromJson(v))),
        height: json["height"].toDouble(),
        length: json["length"].toDouble(),
        model: json["model"],
        picture: json["picture"],
        weight: json["weight"],
        width: json["width"].toDouble(),
        year: json["year"],
    );

    Map<String, dynamic> toJson() => {
        "bodywork": bodywork,
        "engines": Map.from(engines).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
        "height": height,
        "length": length,
        "model": model,
        "picture": picture,
        "weight": weight,
        "width": width,
        "year": year,
    };
}

class Engine {
    Engine({
        this.consumption,
        this.drive,
        this.fuel,
        this.gearboxGears,
        this.gearboxType,
        this.name,
        this.power,
        this.torque,
    });

    double consumption;
    String drive;
    String fuel;
    int gearboxGears;
    String gearboxType;
    String name;
    int power;
    int torque;

    factory Engine.fromJson(Map<String, dynamic> json) => Engine(
        consumption: json["consumption"].toDouble(),
        drive: json["drive"],
        fuel: json["fuel"],
        gearboxGears: json["gearbox-gears"],
        gearboxType: json["gearbox-type"],
        name: json["name"],
        power: json["power"],
        torque: json["torque"],
    );

    Map<String, dynamic> toJson() => {
        "consumption": consumption,
        "drive": drive,
        "fuel": fuel,
        "gearbox-gears": gearboxGears,
        "gearbox-type": gearboxType,
        "name": name,
        "power": power,
        "torque": torque,
    };
}
