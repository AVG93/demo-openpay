
import 'dart:convert';
import 'dart:io';

import 'package:demo_openpay/src/api/routes.dart';
import 'package:demo_openpay/src/models/Cliente.dart';
import 'package:http/http.dart' as http;

class ClienteService{

  ClienteService._privateContructor();
  static final ClienteService _instance = ClienteService._privateContructor();
  factory ClienteService() {
    return _instance;
  }


  Future<List<Cliente>> getClientes({int limit = 25}) async {
    
    final response = await http.get(
      Uri.parse(Routes.getClientes), 
      headers: Routes.headersOpenPay,
    );

    final responseJson = jsonDecode(response.body);
    if(Routes.printResponses){print(responseJson);}

    return List<Cliente>.from(responseJson.map((x) => Cliente.fromJson(x)));
  }




}