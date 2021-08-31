import 'package:demo_openpay/src/models/Cliente.dart';
import 'package:flutter/material.dart';

class ClienteDetallePage extends StatefulWidget {
  ClienteDetallePage({Key? key}) : super(key: key);

  @override
  _ClienteDetallePageState createState() => _ClienteDetallePageState();
}

class _ClienteDetallePageState extends State<ClienteDetallePage> {
  @override
  Widget build(BuildContext context) {

    final Cliente cliente = ModalRoute.of(context)!.settings.arguments as Cliente;


    return Scaffold(
      appBar: AppBar(
        title: Text(cliente.name),
      ),
    );
  }
}