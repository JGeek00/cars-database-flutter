import 'dart:convert';

EngineModel engineModelFromJson(String str) => EngineModel.fromJson(json.decode(str));

String engineModelToJson(EngineModel data) => json.encode(data.toJson());

class EngineModel {
    EngineModel({
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

    factory EngineModel.fromJson(Map<String, dynamic> json) => EngineModel(
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
