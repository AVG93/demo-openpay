import 'package:demo_openpay/src/widgets/styles/styles.dart';
import 'package:flutter/material.dart';



Widget inputTextRegistro(String placeHolder, TextInputType typeInput, bool isPassword, TextEditingController control, [String texto = '', IconData? icono]) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      texto != '' 
      ? Text( texto,
        style: labelBoldAzul,
      )
      : SizedBox(),
      
      SizedBox(height: 20.0),
      Container(
        alignment: Alignment.centerLeft,
        height: 45.0,
        child: TextField(
          obscureText: isPassword,
          keyboardType: typeInput,
          controller: control,
          //style: textInputStyle,
          decoration: InputDecoration(
            hintText: placeHolder,
            hintStyle: labelGris,
          ),
        ),
      ),
    ],
  );
}

