import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Loading extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        backgroundColor: Colors.grey[200],
        valueColor: AlwaysStoppedAnimation(Colors.blue),
      ),
    );
  }

}