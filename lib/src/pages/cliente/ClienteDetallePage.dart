import 'package:demo_openpay/src/models/Cliente.dart';
import 'package:demo_openpay/src/widgets/itemDataInput.dart';
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

    TextEditingController _name = TextEditingController();
    TextEditingController _lastName = TextEditingController();
    TextEditingController _email = TextEditingController();
    TextEditingController _phone = TextEditingController();
    TextEditingController _line1 = TextEditingController();
    TextEditingController _line2 = TextEditingController();
    TextEditingController _postalCode = TextEditingController();
    TextEditingController _state = TextEditingController();
    TextEditingController _city = TextEditingController();
    TextEditingController _countryCode = TextEditingController();

    _name.text = cliente.name;
    _lastName.text = cliente.lastName!;
    _email.text = cliente.email;
    _phone.text = cliente.phoneNumber!;
    _line1.text = cliente.address!.line1;
    _line2.text = cliente.address!.line2!;
    _postalCode.text = cliente.address!.postalCode;
    _city.text = cliente.address!.city;
    _state.text = cliente.address!.state;
    _countryCode.text = cliente.address!.countryCode;

    final _screenSize = MediaQuery.of(context).size;






    return Scaffold(
      appBar: AppBar(
        title: Text(cliente.name),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          
          children: [

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Container(
                  width: _screenSize.width*.42,
                  child: inputTextRegistro('Nombre', TextInputType.name, false, _name)
                ),
                Container(
                  width: _screenSize.width*.42,
                  child: inputTextRegistro('Apellidos', TextInputType.name, false, _lastName)
                ),

              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Container(
                  width: _screenSize.width*.42,
                  child: inputTextRegistro('Email', TextInputType.emailAddress, false, _email),
                ),
                Container(
                  width: _screenSize.width*.42,
                  child: inputTextRegistro('Telefono', TextInputType.phone, false, _phone),
                ),

              ],
            ),

            inputTextRegistro('Calle', TextInputType.text, false, _line1),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Container(
                  width: _screenSize.width*.54,
                  child: inputTextRegistro('Colonia', TextInputType.text, false, _line2),
                ),
                Container(
                  width: _screenSize.width*.3,
                  child: inputTextRegistro('Codigo Postal', TextInputType.number, false, _postalCode),
                ),

              ],
            ),



            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Container(
                  width: _screenSize.width*.3,
                  child: inputTextRegistro('Ciudad', TextInputType.text, false, _city),
                ),
                Container(
                  width: _screenSize.width*.3,
                  child: inputTextRegistro('Estado', TextInputType.text, false, _state),
                ),
                Container(
                  width: _screenSize.width*.1,
                  child: inputTextRegistro('Pais Code', TextInputType.text, false, _countryCode),
                ),

              ],
            ),
            
            
            
            
            
            
          ],
        ),
      ),
    );
  }
}