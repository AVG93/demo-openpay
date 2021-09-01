import 'dart:convert';

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
    //if(Routes.printResponses){print(responseJson);}

    return List<Cliente>.from(responseJson.map((x) => Cliente.fromJson(x)));
  }


  Future<Cliente> postCliente(Cliente c) async {

    dynamic response;

    try{
      response = await http.post(
        Uri.parse(Routes.postCliente), 
        headers: Routes.headersOpenPay,
        body: ClienteToJson(c)
      );

      final responseJson = jsonDecode(response.body);
      if(Routes.printResponses){print(responseJson);}

      c = ClienteFromJson(response.body);
    }
    catch(ex){
      c.error = true;
      c.mensaje = jsonDecode(response.body)['description'];
    }

    return c;
  }


  Future<bool> deleteCliente(String clienteId) async {
    
    final response = await http.delete(
      Uri.parse(Routes.deleteCliente + '/$clienteId'), 
      headers: Routes.headersOpenPay
    );

    if(Routes.printResponses){print(response.toString());}

    return response.statusCode == 204 ? true : false;
  }

  Future<Cliente> updateCliente(Cliente c) async {

    dynamic response;

    try{
      response = await http.put(
        Uri.parse(Routes.updateCliente + '/${c.id}'), 
        headers: Routes.headersOpenPay,
        body: ClienteToJson(c)
      );
      
      final responseJson = jsonDecode(response.body);
      if(Routes.printResponses){print(responseJson);}

      c = ClienteFromJson(response.body);
    }
    catch(ex){
      c.error = true;
      c.mensaje = jsonDecode(response.body)['description'];
    }
    
    return c;
  }





}