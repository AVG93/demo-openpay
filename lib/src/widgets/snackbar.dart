

import 'package:flutter/material.dart';

class Snacks{

  late BuildContext context;

  Snacks(BuildContext context){
    this.context = context;
  }

  void error(String msg){
    ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(backgroundColor: Colors.orange, content: Text('Error: $msg')));

  }


  void success(String msg){
    ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(backgroundColor: Colors.green, content: Text(msg)));

  }

}

