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
