// To parse this JSON data, do
//
//     final sucursales = sucursalesFromJson(jsonString);

import 'dart:convert';

List<Sucursales> sucursalesFromJson(String str) => List<Sucursales>.from(json.decode(str).map((x) => Sucursales.fromJson(x)));

String sucursalesToJson(List<Sucursales> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Sucursales {
    Sucursales({
        required this.idStore,
        required this.id,
        required this.idSubChain,
        required this.name,
        required this.lastUpdate,
        required this.status,
        required this.geolocation,
        required this.address,
        required this.paynetChain,
    });

    int idStore;
    int id;
    int idSubChain;
    String name;
    DateTime lastUpdate;
    String status;
    Geolocation geolocation;
    Address address;
    PaynetChain paynetChain;

    factory Sucursales.fromJson(Map<String, dynamic> json) => Sucursales(
        idStore: json["id_store"],
        id: json["id"],
        idSubChain: json["id_sub_chain"],
        name: json["name"],
        lastUpdate: DateTime.parse(json["last_update"]),
        status: json["status"],
        geolocation: Geolocation.fromJson(json["geolocation"]),
        address: Address.fromJson(json["address"]),
        paynetChain: PaynetChain.fromJson(json["paynet_chain"]),
    );

    Map<String, dynamic> toJson() => {
        "id_store": idStore,
        "id": id,
        "id_sub_chain": idSubChain,
        "name": name,
        "last_update": lastUpdate.toIso8601String(),
        "status": status,
        "geolocation": geolocation.toJson(),
        "address": address.toJson(),
        "paynet_chain": paynetChain.toJson(),
    };
}

class Address {
    Address({
        required this.line1,
        required this.line2,
        this.line3,
        required this.state,
        required this.city,
        required this.postalCode,
        required this.countryCode,
    });

    String line1;
    String line2;
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



class Geolocation {
    Geolocation({
        required this.lng,
        required this.lat,
        required this.placeId,
    });

    double lng;
    double lat;
    String placeId;

    factory Geolocation.fromJson(Map<String, dynamic> json) => Geolocation(
        lng: json["lng"].toDouble(),
        lat: json["lat"].toDouble(),
        placeId: json["place_id"],
    );

    Map<String, dynamic> toJson() => {
        "lng": lng,
        "lat": lat,
        "place_id": placeId,
    };
}

class PaynetChain {
    PaynetChain({
        required this.idPaynetChain,
        required this.name,
        required this.publicId,
        this.logo,
        this.thumb,
    });

    int idPaynetChain;
    String name;
    String publicId;
    String? logo;
    String? thumb;

    factory PaynetChain.fromJson(Map<String, dynamic> json) => PaynetChain(
        idPaynetChain: json["id_paynet_chain"],
        name: json["name"],
        publicId: json["public_id"],
        logo: json["logo"],
        thumb: json["thumb"],
    );

    Map<String, dynamic> toJson() => {
        "id_paynet_chain": idPaynetChain,
        "name": name,
        "public_id": publicId,
        "logo": logo,
        "thumb": thumb,
    };
}





