
import 'package:flutter/material.dart';
import 'package:flutter_time_saver/model/DataToDisk.dart';

import './DeleteTaskDialog.dart';
import 'StyleTextItem.dart';
class DisplayTask extends StatelessWidget {
  DataToDisk? dataToDisk;
  /* below we define callback function. this is set in main.dart when we call DisplayTask
  then as the user confirms to delete an Item we call this function with passing index.
  here is statelesswidget we cant set state so We have decided to use callback function to setstate
  in parent statefull widget.
  below we indicate that callback functon has parameter index which is the item will be deleted
  if we didnt have index we would define this function normally
  */
  Function(int index) DeletTaskCallback;
  Function(int index,String Running) RunStopCallback;
  Function(String Task) ExpandTask;
  DisplayTask(this.dataToDisk, this.DeletTaskCallback, this.RunStopCallback,this.ExpandTask);
  @override
  Widget build(BuildContext context){
      return ListView.builder(
        itemCount: dataToDisk!.UserData.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              Container(
                color: Colors.grey,
                child: InkWell(
                  onTap: (){
                    ExpandTask(dataToDisk!.UserData.elementAt(index).taskName);
                  },
                  child: Row(children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child:
                            dataToDisk!.UserHashData[dataToDisk!.UserData.elementAt(index).taskName]!.elementAt(0).Running == true.toString()
                                ? IconButton(
                                    onPressed: () {RunStopCallback(index,"false");},
                                    icon: Icon(
                                      Icons.play_circle,
                                      size: 40,
                                      color: Colors.red,
                                    ),
                                  )
                                : IconButton(
                                    icon: Icon(
                                      Icons.stop,
                                      size: 40,
                                      color: Colors.black,
                                    ),
                                    onPressed: () {RunStopCallback(index,"true");},
                                  ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Text(
                          dataToDisk!.UserData.elementAt(index).taskName.toString(),
                          style: StyleTextItem.style,
                        ),
                      ),

                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: IconButton(
                          icon: Icon(
                            Icons.delete,
                            size: 40,
                          ),
                          onPressed: () {
                            DeleteTaskDialog(context).then((value) {
                              if (value == "true") {
                                DeletTaskCallback(index);
                              }
                            });
                          },
                        ),
                      ),
                    )
                  ]),
                ),
              ),
              SizedBox(height: 5),
            ],
          );
        });
  }
}
