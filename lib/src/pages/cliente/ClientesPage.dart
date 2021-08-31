import 'package:demo_openpay/src/api/ClienteService.dart';
import 'package:demo_openpay/src/models/Cliente.dart';
import 'package:demo_openpay/src/widgets/itemCliente.dart';
import 'package:flutter/material.dart';

class ClientesPage extends StatefulWidget {
  ClientesPage({Key? key}) : super(key: key);

  @override
  _ClientesPageState createState() => _ClientesPageState();
}

class _ClientesPageState extends State<ClientesPage> {

  ClienteService clienteService = new ClienteService();


  Widget _loadVisitantes(BuildContext context){

    return FutureBuilder(
      future: clienteService.getClientes(),
      builder: (BuildContext context, AsyncSnapshot<List<Cliente>> snapshot) {
        if(snapshot.hasData){
          print(snapshot.data);
          
          return _drawVisitanteItems(snapshot.data!, context);
        }
        else{
          return Container(
            height: 400.0,
            child: Center( child: CircularProgressIndicator())
          );
        }
      },
    );

  }

  Widget _drawVisitanteItems(List<Cliente> visitantes, BuildContext context){

    if(visitantes.length > 0){
      return ListView.separated(
        itemCount: visitantes.length,
        itemBuilder: (BuildContext context, int index) {
          return itemCliente(context, visitantes[index], this.onClickItemCliente);
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      );
    }
    else{
      return Container(
        child: Center( child: Text('Actualmente no tienes ningun cliente :('))
      );
    }

    

  }

  void onClickAddCliente(){
    Navigator.pushNamed(context, '/clienteAlta');//es un distinto tipo
  }

  void onClickItemCliente(Cliente c){
    Navigator.pushNamed(context, '/clienteDetalle', arguments: c);//es un distinto tipo
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Demo Open Pay API'),
      ),
      body: Builder(
        builder: (context) => Container(
          child: _loadVisitantes(context),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: this.onClickAddCliente,
        child: Icon(Icons.add),
      ),
    );
  }
}