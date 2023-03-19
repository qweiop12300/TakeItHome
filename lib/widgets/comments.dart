import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'my_notification.dart';

class CommentsView{

  static Future<MyNotification?> showBottomView(BuildContext context) async{
    return await showModalBottomSheet<MyNotification>(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          child: Text("hhhh"),
        );
      },
    );
  }
}