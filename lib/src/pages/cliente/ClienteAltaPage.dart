import 'package:demo_openpay/src/api/ClienteService.dart';
import 'package:demo_openpay/src/models/Cliente.dart';
import 'package:flutter/material.dart';


class ClienteAltaPage extends StatefulWidget {
  ClienteAltaPage({Key? key}) : super(key: key);

  @override
  _ClienteAltaPageState createState() => _ClienteAltaPageState();
}

class _ClienteAltaPageState extends State<ClienteAltaPage> {
  @override
  Widget build(BuildContext context) {

    ClienteService clienteService = new ClienteService();

    clienteService.postCliente(new Cliente(id: '', name: 'Username test', email: 'email@correo.com', creationDate: new DateTime(1990, 01, 01)))
    .then((c) => {
      print('${c.id} - ${c.name}')
    });


    return Scaffold(
      appBar: AppBar(
        title: Text('Alta de Cliente'),
        
      ),

    );
  }
}