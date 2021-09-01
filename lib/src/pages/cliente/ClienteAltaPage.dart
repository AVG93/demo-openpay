import 'dart:async';

import 'package:demo_openpay/src/api/ClienteService.dart';
import 'package:demo_openpay/src/models/Cliente.dart';
import 'package:demo_openpay/src/widgets/itemDataInput.dart';
import 'package:demo_openpay/src/widgets/modals.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class ClienteAltaPage extends StatefulWidget {
  ClienteAltaPage({Key? key}) : super(key: key);

  @override
  _ClienteAltaPageState createState() => _ClienteAltaPageState();
}

class _ClienteAltaPageState extends State<ClienteAltaPage> {

  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(24.1600263,-101.4227029),
    zoom: 5,
  );

  static final CameraPosition _coords = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(24.1600263,-101.4227029),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  Map<String, Marker> _markers = {};


  var marker = _kGooglePlex.target;


  void onClickAltaCliente(Cliente c){
    ClienteService clienteService = new ClienteService();

    modalLoading(context, 'Procesando ...', true);

    clienteService.postCliente(c)
    .then((c){
      Navigator.pop(context);
      if(c.error){
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(backgroundColor: Colors.orange, content: Text('Error: ${c.mensaje}')));
      }
      else{
        print('${c.id} - ${c.name}');
        Navigator.popAndPushNamed(context, '/clientes');
      }
    });
  }

  Widget mapSegment(){
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      width: _screenSize.width*.8,
      height: _screenSize.height*.3,
      child: GoogleMap(
        myLocationButtonEnabled: false,
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller){
          _controller.complete(controller);
        },
        onTap: (LatLng coords){

          print(coords.latitude.toString() + ', ' + coords.longitude.toString());

        },
        markers: _markers.values.toSet(),
      )
    );
  }


  @override
  Widget build(BuildContext context) {

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

    final _screenSize = MediaQuery.of(context).size;


    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){

            Navigator.popAndPushNamed(context, '/clientes');
          }, 
          icon: Icon(Icons.arrow_back),
          disabledColor: Colors.red,
        ),
        title: Text('Alta de Cliente'),
        actions: [
          IconButton(
            onPressed: (){

              onClickAltaCliente(new Cliente(
                id: '', 
                name: _name.text, 
                lastName: _lastName.text,
                email: _email.text, 
                phoneNumber: _phone.text,
                address: new Address(
                  line1: _line1.text, 
                  line2: _line2.text, 
                  state: _state.text, 
                  city: _city.text, 
                  postalCode: _postalCode.text, 
                  countryCode: _countryCode.text),
                creationDate: new DateTime(1990, 01, 01),

                )
              );

            }, 
            icon: Icon(Icons.check),
            disabledColor: Colors.red,
          )
        ],
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
                  child: inputTextRegistro('* Nombre', TextInputType.name, false, _name)
                ),
                Container(
                  width: _screenSize.width*.42,
                  child: inputTextRegistro('Apellidos', TextInputType.name, false, _lastName)
                ),

              ],
            ),

            inputTextRegistro('* Email', TextInputType.emailAddress, false, _email),

            inputTextRegistro('Telefono', TextInputType.phone, false, _phone),

            SizedBox(height: 20.0,),

            mapSegment(),


            inputTextRegistro('* Calle', TextInputType.text, false, _line1),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Container(
                  width: _screenSize.width*.54,
                  child: inputTextRegistro('* Colonia', TextInputType.text, false, _line2),
                ),
                Container(
                  width: _screenSize.width*.3,
                  child: inputTextRegistro('* Codigo Postal', TextInputType.number, false, _postalCode),
                ),

              ],
            ),



            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Container(
                  width: _screenSize.width*.3,
                  child: inputTextRegistro('* Ciudad', TextInputType.text, false, _city),
                ),
                Container(
                  width: _screenSize.width*.3,
                  child: inputTextRegistro('* Estado', TextInputType.text, false, _state),
                ),
                Container(
                  width: _screenSize.width*.1,
                  child: inputTextRegistro('* Pais Code', TextInputType.text, false, _countryCode),
                ),

              ],
            ),

            
            
          ],
        ),
      ),

    );
  }

  
}