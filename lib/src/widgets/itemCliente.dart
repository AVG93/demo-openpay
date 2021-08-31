

import 'package:demo_openpay/src/models/Cliente.dart';
import 'package:flutter/material.dart';

Widget itemCliente(BuildContext context, Cliente c, Function onClick, Function onDismiss, int index){
    final _screenSize = MediaQuery.of(context).size;
    
    Icon icon = Icon(Icons.place, color: Colors.white,);
    Color colorContent = Colors.green;
    
    if(c.address == null){
      colorContent = Color(0xFFFF5555);
    }

    Widget line_1 = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[        
        Text(c.email)
      ],
    );

    Widget line_2 = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[        
        c.address != null ? Text(c.address!.city) : Text('NA'),
        Text(c.creationDate.toString().substring(5, 16))
      ],

    );
    

    return Dismissible(
      key: ValueKey(c.id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
      ),
      onDismissed: (DismissDirection ds){
        onDismiss(c, index);
      },
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(100.0),
          child: Container(
            width: _screenSize.width*.1,
            height: _screenSize.width*.1,
            color: colorContent,
            child: icon,
          ),
        ),
        title: line_1,
        subtitle: line_2,
        onTap: (){
          onClick(c);
        },
      ),
    );
  }

