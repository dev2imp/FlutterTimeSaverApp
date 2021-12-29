import 'package:flutter/material.dart';
import 'package:flutter_time_saver/model/DataToDisk.dart';
import 'package:flutter_time_saver/view/StyleTextItem.dart';
class ExpandWork extends StatelessWidget{
  DataToDisk? dataToDisk;
  String taskname;
  Function BackArrow;
  ExpandWork(this.dataToDisk,this.taskname,this.BackArrow);
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 30,
        leading:
          Container(
            color: Colors.grey,
            alignment: Alignment.center,
            child: IconButton(
              padding: EdgeInsets.all(0),
              onPressed:(){
                BackArrow();
              },
              icon: Icon(Icons.arrow_back,
              size: 30,
              ),
            ),
          ),
      ),
      body: ListView.builder(
          itemCount: dataToDisk!.UserHashData[taskname]!.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                SizedBox(height: 5,),
                Container(
                  width: double.infinity,
                  color: Colors.grey,
                  child: Column(
                    children: [
                      Text("${dataToDisk!.UserHashData[taskname]!.elementAt(index).Year}/"
                          "${dataToDisk!.UserHashData[taskname]!.elementAt(index).Month}/"
                          "${dataToDisk!.UserHashData[taskname]!.elementAt(index).Day}",
                        style: StyleTextItem.style,
                      ),
                      Text("${dataToDisk!.UserHashData[taskname]!.elementAt(index).Hour}:"
                          "${dataToDisk!.UserHashData[taskname]!.elementAt(index).Minute}:"
                          "00",
                        style: StyleTextItem.style,
                      ),
                    Text("${dataToDisk!.UserHashData[taskname]!.elementAt(index).TotalWork}",
                      style: StyleTextItem.style)
                    ],
                  ),
                ),
              ],
            );
          }
      ),
    );
  }
}
