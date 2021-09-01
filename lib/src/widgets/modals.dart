import 'package:flutter/material.dart';

Future<T?> modalLoading<T>(BuildContext context, String titulo, bool linearLoader) async {
    
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Center(
          child:  Text(titulo)
        ),
        content: Container(
          //child: Text(mensaje),
          child: linearLoader ? LinearProgressIndicator(backgroundColor: Colors.white,) : CircularProgressIndicator(),
        ),
      );
    }
  );
}


Future<T?> modalConfirmar<T>(BuildContext context, String titulo, String mensaje, Function onTapSi, [String textoSi = 'SI', String textoNo = 'NO', Function? onTapNo]) async {
    
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(titulo),
        content: Container(
          child: Text(mensaje),
        ),
        actions: <Widget>[
          new FlatButton(
            child: new Text(textoNo),
            onPressed: () {
              if(onTapNo == null){
                Navigator.pop(context);
              }
              else{
                onTapNo();
              }
            },
          ),
          new FlatButton(
            child: new Text(textoSi),
            onPressed: () {
              onTapSi();
            },
          )
        ],
      );
    }
  );
}