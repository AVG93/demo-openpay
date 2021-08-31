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

  List<Cliente> clientes = <Cliente>[];


  Widget _loadClientes(BuildContext context){

    return FutureBuilder(
      future: clienteService.getClientes(),
      builder: (BuildContext context, AsyncSnapshot<List<Cliente>> snapshot) {
        if(snapshot.hasData){
          print(snapshot.data);

          this.clientes = snapshot.data!;
          
          return _drawClienteItems(this.clientes, context);
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

  Widget _drawClienteItems(List<Cliente> clientes, BuildContext context){

    if(clientes.length > 0){
      return ListView.builder(
        itemCount: clientes.length,
        itemBuilder: (BuildContext context, int index) {
          return itemCliente(context, clientes[index], this.onClickItemCliente, this.onDismissItemCliente, index);
        },
        //separatorBuilder: (BuildContext context, int index) => const Divider(),
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

  void onDismissItemCliente(Cliente c, int index){

    clienteService.deleteCliente(c.id).then((resp){

      setState(() {
        //items.removeAt(index);
        this.clientes.removeAt(index);
        print(this.clientes.length);
      });
      
      ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('${c.email} eliminado')));

    });

    
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Demo Open Pay API'),
      ),
      body: Builder(
        builder: (context) => Container(
          child: _loadClientes(context),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: this.onClickAddCliente,
        child: Icon(Icons.add),
      ),
    );
  }
}