// To parse this JSON data, do
//
//     final Cliente = ClienteFromJson(jsonString);

import 'dart:convert';

List<Cliente> ClientesFromJson(String str) => List<Cliente>.from(json.decode(str).map((x) => Cliente.fromJson(x)));

String ClientesToJson(List<Cliente> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

Cliente ClienteFromJson(String str) => Cliente.fromJson(json.decode(str));

String ClienteToJson(Cliente data) => json.encode(data.toJson());





class Cliente {
    Cliente({
        required this.id,
        required this.name,
        this.lastName,
        required this.email,
        this.phoneNumber,
        this.address,
        required this.creationDate,
        this.externalId,
        this.clabe,
    });

    String id;
    String name;
    String? lastName;
    String email;
    String? phoneNumber;
    Address? address;
    DateTime creationDate;
    String? externalId;
    String? clabe;

    factory Cliente.fromJson(Map<String, dynamic> json) => Cliente(
        id: json["id"],
        name: json["name"],
        lastName: json["last_name"] == null ? null : json["last_name"],
        email: json["email"],
        phoneNumber: json["phone_number"] == null ? null : json["phone_number"],
        address: json["address"] == null ? null : Address.fromJson(json["address"]),
        creationDate: DateTime.parse(json["creation_date"]),
        externalId: json["external_id"] == null ? null : json["external_id"],
        clabe: json["clabe"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "last_name": lastName == null ? null : lastName,
        "email": email,
        "phone_number": phoneNumber == null ? null : phoneNumber,
        "address": address == null ? null : address!.toJson(),
        "creation_date": creationDate.toIso8601String(),
        "external_id": externalId == null ? null : externalId,
        "clabe": clabe,
    };
}

class Address {
    Address({
        required this.line1,
        this.line2,
        this.line3,
        required this.state,
        required this.city,
        required this.postalCode,
        required this.countryCode,
    });

    String line1;
    String? line2;
    String? line3;
    String state;
    String city;
    String postalCode;
    String countryCode;

    factory Address.fromJson(Map<String, dynamic> json) => Address(
        line1: json["line1"],
        line2: json["line2"],
        line3: json["line3"],
        state: json["state"],
        city: json["city"],
        postalCode: json["postal_code"],
        countryCode: json["country_code"],
    );

    Map<String, dynamic> toJson() => {
        "line1": line1,
        "line2": line2,
        "line3": line3,
        "state": state,
        "city": city,
        "postal_code": postalCode,
        "country_code": countryCode,
    };
}
