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


class ClienteAltaPage extends StatefulWidget {
  ClienteAltaPage({Key? key}) : super(key: key);

  @override
  _ClienteAltaPageState createState() => _ClienteAltaPageState();
}

class _ClienteAltaPageState extends State<ClienteAltaPage> {

  Completer<GoogleMapController> _controller = Completer();

  CameraPosition camPos = CameraPosition(
    target: LatLng(24.1600263,-101.4227029),
    zoom: 5,
  );


  late MapaGoogle ggMap;
  late GoogleMap pickMap;
  final Map<String, Marker> markers = {};

  late Snacks snack;

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


  void onClickAltaCliente(){
    
    ClienteService clienteService = new ClienteService();
    Cliente c = new Cliente(
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
    );

    modalLoading(context, 'Procesando ...', true);

    clienteService.postCliente(c)
    .then((c){
      Navigator.pop(context);
      if(c.error){
        snack.error(c.mensaje!);
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

      addMarker(coords);

      ggMap.moveCamera(CameraPosition(
        target: coords,
        zoom: 15,
      ));

      ggMap.getDataFromCoords(coords).then((resp){
        print(resp);
        setCoordsData(resp[0]);
      });
      
    });
  }

  void addMarker(LatLng coords){

    markers.clear();
    final marker = Marker(
      markerId: MarkerId('Tu'),
      position: coords,
      infoWindow: InfoWindow(
        title: 'Tu direccion',
        snippet: '',
      ),
    );
    markers['Tu'] = marker;
  }

  void setCoordsData(Placemark data){
    _line1.text = data.street.toString();
    _line2.text = data.subLocality.toString();
    _city.text = data.locality.toString();
    _state.text = data.administrativeArea.toString();
    _postalCode.text = data.postalCode.toString();
    _countryCode.text = data.isoCountryCode.toString();

  }

  
  Widget bodySegment(){
    final _screenSize = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Container(
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
    
            Container(
              width: _screenSize.width*.8,
              height: _screenSize.height*.3,
              child: pickMap
            ),
    
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
                  width: _screenSize.width*.2,
                  child: inputTextRegistro('* Pais Code', TextInputType.text, false, _countryCode),
                ),
              ],
            ),

            SizedBox(height: 40.0,),
          ],
        ),
      ),
    );
  }

  
  @override
  Widget build(BuildContext context) {

    this.snack = Snacks(context);
    this.ggMap = new MapaGoogle(_controller, camPos);
    this.ggMap.setMarkers(markers);
    pickMap = ggMap.map(onTapMap);

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
            onPressed: onClickAltaCliente, 
            icon: Icon(Icons.check),
            disabledColor: Colors.red,
          )
        ],
      ),
      body: bodySegment(),
    );
  }

  
}