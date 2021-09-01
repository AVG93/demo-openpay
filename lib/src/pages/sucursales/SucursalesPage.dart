import 'dart:async';

import 'package:demo_openpay/src/api/SucursalService.dart';
import 'package:demo_openpay/src/models/Sucursal.dart';
import 'package:demo_openpay/src/widgets/map.dart';
import 'package:demo_openpay/src/widgets/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SucursalesPage extends StatefulWidget {
  SucursalesPage({Key? key}) : super(key: key);

  @override
  _SucursalesPageState createState() => _SucursalesPageState();
}

class _SucursalesPageState extends State<SucursalesPage> {

  late CameraPosition camPos;
  late MapaGoogle ggMap;
  final Map<String, Marker> markers = {};
  double radioKm = 5;
  double radioKmTmp = 5;
  int resultados = -1;
  bool editRange = false;
  bool mapVisible = false;

  SucursalService sucursalService = new SucursalService();

  Completer<GoogleMapController> _controller = Completer();


  Widget bodySegment(){
    final _screenSize = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            
            mapItem(_screenSize),

            sliderItem(_screenSize),
            
            resultsItem(_screenSize),

            listItem(_screenSize)

          ],
        ),
      ),
    );
  }

  Widget sliderItem(Size _screenSize){

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [

        Container(
          width: _screenSize.width*.15,
          child: Center(
            child: Text(
              radioKm.toInt().toString() + ' km',
            )
          ),
        ),

        Container(
          width: _screenSize.width*.6,
          child: Slider(
            value: radioKm, 
            onChangeEnd: (val){

              if(val != radioKmTmp){
                radioKmTmp = val.toInt().toDouble();
                print('END');

                
                this.sucursalService.getSucursales(camPos.target.latitude, camPos.target.longitude, radioKm)
                  .then((resp){
                    setState(() {
                      print('SUCURSALES: ${resp.length}');
                      resultados = resp.length;

                      setMarkers(resp);
                    });
                    
                  });

              }

              

            },
            onChanged: (val){
              
              if(val != radioKm){
                print('CHANGE');
                setState(() {
                  radioKm = val.toInt().toDouble();
                });
              }
                
              
            },
            min: 1.0,
            max: 10.0,
            divisions: 10,
          ),
        ),

        Container(
          width: _screenSize.width*.05,
          child: Center(
            child: Text('')
          ),
        ),
      ],
    );

  }

  Widget mapItem(Size _screenSize){
    return mapVisible 
    ? Container(
        height: _screenSize.height*.4,
        child: ggMap.map((coords){
          
        }),
      ) 
    : Container();
  }

  Widget resultsItem(Size _screenSize){
    return resultados > -1 
    ? Container(
        color: gris,
        height: _screenSize.height*.05,
        width: _screenSize.width,
        child: Center(
          child: Text(
            resultados > -1 ? '$resultados resultados': '',
            style: TextStyle(
              color: Colors.white
            ),
          ),
        ),
      ) 
    : Container();
  }

  Widget listItem(Size _screenSize){
    return Container(
      height: _screenSize.height*.8,
      width: _screenSize.width,
      child: Builder(
        builder: (context) => Container(
          child: _loadSucursales(context),
        ),
      ),
    );
  }


  void setMarkers(List<Sucursales> sucursales){
    markers.clear();
    for (final suc in sucursales) {
      final marker = Marker(
        markerId: MarkerId(suc.id.toString()),
        position: LatLng(suc.geolocation.lat, suc.geolocation.lng),
        infoWindow: InfoWindow(
          title: suc.paynetChain.name,
          snippet: suc.address.line1,
        ),
      );
      markers[suc.id.toString()] = marker;
    }
  }


  Widget _loadSucursales(BuildContext context){

    return FutureBuilder(
      future: sucursalService.getSucursales(camPos.target.latitude, camPos.target.longitude, radioKm),
      builder: (BuildContext context, AsyncSnapshot<List<Sucursales>> snapshot) {
        if(snapshot.hasData){
          
          resultados = snapshot.data!.length;
          setMarkers(snapshot.data!);
          
          return _drawSucursalItems(snapshot.data!, context);
        }
        else{
          return Container(
            height: 300.0,
            child: Center( child: CircularProgressIndicator())
          );
        }
      },
    );

  }

  Widget _drawSucursalItems(List<Sucursales> sucursales, BuildContext context){

    if(sucursales.length > 0){
      return ListView.separated(
        itemCount: sucursales.length,
        separatorBuilder: (BuildContext context, int index) => Divider(),
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(sucursales[index].paynetChain.name.toString()),
            subtitle: Text(sucursales[index].address.line1.toString()),
            onTap: (){
              
            },
          );
        },
      );
    }
    else{
      return Container(
        child: Center(
          child: Text('No se encontraron sucursales'),
        ),
      );
    }

  }



  @override
  Widget build(BuildContext context) {
    
    this.camPos = ModalRoute.of(context)!.settings.arguments as CameraPosition;
    this.ggMap = new MapaGoogle(_controller, camPos);
    this.ggMap.setMarkers(markers);

    return Scaffold(
      appBar: AppBar(
        title: Text('Sucursales'),
        actions: [
          IconButton(
            onPressed: (){
              setState(() {
                mapVisible = !mapVisible;
              });
            }, 
            icon: Icon(Icons.map),
            disabledColor: Colors.red,
          )
        ],
      ),
      body: bodySegment()
    );
  }
}