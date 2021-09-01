import 'dart:async';

import 'package:demo_openpay/src/api/ClienteService.dart';
import 'package:demo_openpay/src/models/Cliente.dart';
import 'package:demo_openpay/src/widgets/itemDataInput.dart';
import 'package:demo_openpay/src/widgets/map.dart';
import 'package:demo_openpay/src/widgets/modals.dart';
import 'package:demo_openpay/src/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ClienteDetallePage extends StatefulWidget {
  ClienteDetallePage({Key? key}) : super(key: key);

  @override
  _ClienteDetallePageState createState() => _ClienteDetallePageState();
}

class _ClienteDetallePageState extends State<ClienteDetallePage> {

  late Snacks snack;
  late MapaGoogle ggMap;
  bool mapEdit = false;

  Completer<GoogleMapController> _controller = Completer();

  CameraPosition camPos = CameraPosition(
    target: LatLng(24.1600263,-101.4227029),
    zoom: 5,
  );


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


  @override
  void initState() {
    super.initState();

    
    
  }

  void setFieldsValues(Cliente cliente){

    if(!mapEdit){
      _name.text = validacionNull(cliente.name);
      _lastName.text = validacionNull(cliente.lastName);
      _email.text = validacionNull(cliente.email);
      _phone.text = validacionNull(cliente.phoneNumber);

      if(cliente.address != null){
        _line1.text = validacionNull(cliente.address!.line1);
        _line2.text = validacionNull(cliente.address!.line2!);
        _postalCode.text = validacionNull(cliente.address!.postalCode);
        _city.text = validacionNull(cliente.address!.city);
        _state.text = validacionNull(cliente.address!.state);
        _countryCode.text = validacionNull(cliente.address!.countryCode);
      }
    }

  }

  String validacionNull(String? text){
    return (text != null ? text: '');
  }

  void onClickUpdateCliente(Cliente c){
    ClienteService clienteService = new ClienteService();

    modalLoading(context, 'Procesando ...', true);

    clienteService.updateCliente(c)
    .then((c){
      Navigator.pop(context);
      if(c.error){
        this.snack.error(c.mensaje!);
      }
      else{
        print('${c.id} - ${c.name}');
        Navigator.popAndPushNamed(context, '/clientes');
      }
    });
  }

  void onTapMap(LatLng coords){
    print(coords.latitude.toString() + ', ' + coords.longitude.toString());

    setState(() {

      mapEdit = true;

      ggMap.moveCamera(CameraPosition(
        target: coords,
        bearing: 0,
        tilt: 0,
        zoom: 15,
      ));

      ggMap.getDataFromCoords(coords).then((resp){
        print(resp);
        setCoordsData(resp[0]);
      });
      
    });
  }

  void onGetCoords(){
    if(!mapEdit){
      setState(() {

        ggMap.getCoordsFromData('${_line1.text}, ${_line2.text} ${_postalCode.text}, ${_city.text}, ${_state.text}, ${_countryCode.text}')
        .then((value){
          print(value[0].latitude);
          print(value[0].longitude);

          ggMap.moveCamera(CameraPosition(
            bearing: 0,
            tilt: value[0].latitude == 0 ? 0 : 90,
            target: LatLng(value[0].latitude, value[0].longitude),
            zoom: value[0].latitude == 0 ? 1 : 15,
          ));
        });
        
      });

    }
    
  }


  void setCoordsData(Placemark data){
    _line1.text = data.street.toString();
    _line2.text = data.subLocality.toString();
    _city.text = data.locality.toString();
    _state.text = data.administrativeArea.toString();
    _postalCode.text = data.postalCode.toString();
    _countryCode.text = data.isoCountryCode.toString();

  }


  @override
  Widget build(BuildContext context) {

    final Cliente cliente = ModalRoute.of(context)!.settings.arguments as Cliente;

    this.snack = Snacks(context);
    this.ggMap = new MapaGoogle(_controller, camPos);

    setFieldsValues(cliente);
    onGetCoords();

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
        title: Text(cliente.name),
        actions: [
          IconButton(
            onPressed: (){

              onClickUpdateCliente(new Cliente(
                id: cliente.id, 
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
                  child: inputTextRegistro('Nombre', TextInputType.name, false, _name)
                ),
                Container(
                  width: _screenSize.width*.42,
                  child: inputTextRegistro('Apellidos', TextInputType.name, false, _lastName)
                ),

              ],
            ),

            inputTextRegistro('* Email', TextInputType.emailAddress, false, _email),

            inputTextRegistro('Telefono', TextInputType.phone, false, _phone),

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

            SizedBox(height: 20.0,),

            Container(
              width: _screenSize.width*.8,
              height: _screenSize.height*.2,
              child: ggMap.map(onTapMap),
            )
            
            
            
            
            
            
          ],
        ),
      ),
    );
  }
}