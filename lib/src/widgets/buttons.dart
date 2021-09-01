import 'package:flutter/material.dart';

Widget normalButton(BuildContext context, String texto, Function validacion, [double w = .4]) {
  final _screenSize = MediaQuery.of(context).size;

  return Container(
    padding: EdgeInsets.symmetric(vertical: 5.0),
    width: _screenSize.width * w,
    height: _screenSize.height * .09,
    child: ElevatedButton(      
      onPressed: () async{
        FocusScope.of(context).requestFocus(new FocusNode());
        validacion();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            texto,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
              fontFamily: 'Montserrat',
            ),
          )

        ],
      )
      
    ),
  );
}
