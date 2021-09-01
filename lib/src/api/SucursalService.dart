import 'dart:convert';

import 'package:demo_openpay/src/api/routes.dart';
import 'package:demo_openpay/src/models/Sucursal.dart';
import 'package:http/http.dart' as http;

class SucursalService{

  SucursalService._privateContructor();
  static final SucursalService _instance = SucursalService._privateContructor();
  factory SucursalService() {
    return _instance;
  }


  Future<List<Sucursales>> getSucursales(double latitud, double longitud, double kilometers, {int ammount = 400}) async {

    String url = Routes.getSucursales + '?latitud=${latitud.toString()}&longitud=${longitud.toString()}&kilometers=${kilometers.toString()}&amount=${ammount.toString()}';
    
    
    final response = await http.get(
      Uri.parse(url)
    );

    final responseJson = jsonDecode(response.body);
    if(Routes.printResponses){print(url);}

    return List<Sucursales>.from(responseJson.map((x) => Sucursales.fromJson(x)));
  }





}