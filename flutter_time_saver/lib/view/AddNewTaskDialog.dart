import 'package:flutter/material.dart';

Future<dynamic> AddNewTaskDialog(BuildContext context) {
  TextEditingController customController = TextEditingController();
  return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          contentPadding:EdgeInsets.all(0),
          children: [
            Container(
              color: Colors.grey,
              alignment: Alignment.center,
              child: Text("Add New Task",
                style: TextStyle(fontSize: 20),
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: TextField(
                controller: customController,
                style: TextStyle(fontSize: 30),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MaterialButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                  child: Text("Cancel",style: TextStyle(fontSize: 20)),

                ),
                MaterialButton(
                  onPressed: (){
                    Navigator.of(context).pop(customController.text.toString());
                  },
                  child: Text("Add",style: TextStyle(fontSize: 20)),
                )
              ],
            )
          ],
        );
      });
}