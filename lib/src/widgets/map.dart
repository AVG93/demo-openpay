import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapaGoogle{

  Completer<GoogleMapController> ctrl = Completer();
  CameraPosition camPos = CameraPosition(target: LatLng(0, 0));
  Map<String, Marker> markers = {};

  MapaGoogle(Completer<GoogleMapController> ctrl, CameraPosition camPos){
    this.ctrl = ctrl;
    this.camPos = camPos;
  }

  GoogleMap map(Function onTap){
    return new GoogleMap(
        markers: this.markers.values.toSet(),
        zoomControlsEnabled: true,
        myLocationButtonEnabled: false,
        mapType: MapType.normal,
        initialCameraPosition: camPos,
        onMapCreated: (GoogleMapController controller){
          try{
            ctrl.complete(controller);
          }
          catch(ex){}
        },
        onTap: (LatLng coords){
          onTap(coords);
        },
        gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
          new Factory<OneSequenceGestureRecognizer>(
            () => new EagerGestureRecognizer(),
          ),
        ].toSet(),
        
      );
  }

  void setMarkers(Map<String, Marker> markers){
    this.markers = markers;
  }

  Future<void> moveCamera(CameraPosition cp) async {
    final GoogleMapController controller = await ctrl.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cp));
  }

  Future<List<Placemark>> getDataFromCoords(LatLng coords) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(coords.latitude, coords.longitude);
    return placemarks;
  }

  Future<List<Location>> getCoordsFromData(String direccion) async {
    
    List<Location> locations = <Location>[];
    try{
      locations = await locationFromAddress(direccion);
    }
    catch(ex){
      locations.add(new Location(latitude: 0, longitude: 0, timestamp: DateTime(1990, 01, 01)));
    }
    
    return locations;
  }



}

