import 'package:flutter/material.dart';


class ClienteAltaPage extends StatefulWidget {
  ClienteAltaPage({Key? key}) : super(key: key);

  @override
  _ClienteAltaPageState createState() => _ClienteAltaPageState();
}

class _ClienteAltaPageState extends State<ClienteAltaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alta de Cliente'),
        
      ),

    );
  }
}