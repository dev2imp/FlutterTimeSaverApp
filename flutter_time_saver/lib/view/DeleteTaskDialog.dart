import 'package:flutter/material.dart';
import 'package:flutter_time_saver/view/StyleTextItem.dart';
Future<dynamic> DeleteTaskDialog(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          contentPadding:EdgeInsets.all(0),
          children: [
            Container(
              alignment: Alignment.center,
              child: Text("Are You Sure to delete Task?",
                style: StyleTextItem.style,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MaterialButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                  child: Text("Cancel"),
                ),
                MaterialButton(
                  onPressed: (){
                    Navigator.of(context).pop("true");
                  },
                  child: Text("Delete"),
                )
              ],
            )
          ],
        );
      });
}