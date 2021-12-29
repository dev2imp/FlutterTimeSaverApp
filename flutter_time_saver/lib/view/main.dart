import 'package:flutter/material.dart';
import 'package:flutter_time_saver/model/DataToDisk.dart';
import 'package:flutter_time_saver/view/AddNewTaskDialog.dart';
import 'package:flutter_time_saver/view/ExpandWork.dart';
import 'package:flutter_time_saver/view/NoTask.dart';
import 'package:flutter_time_saver/view/StyleTextItem.dart';
import './DisplayTask.dart';
void main()=>runApp(MaterialApp(
  home: MyApp(),
));
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {
  DataToDisk? dataToDisk=null;
  bool expand=false;
  String taskname="";
  addNewTask(newTask){
    setState(() {
      dataToDisk!.updateData(newTask);
    });
  }


  @override
  void initState() {
    dataToDisk=DataToDisk((){
      setState(() {
      });
    });
  }
  @override
  Widget build(BuildContext context) {

    return  SafeArea(
          child: Scaffold(
            body: dataToDisk!.UserData.length > 0 ?
            !expand ?
            DisplayTask(
                dataToDisk,
                  (index){
                  setState(() {
                    dataToDisk!.RemoveItemAt(index);
                  });

            },
                (index,running){
                  setState(() {
                    dataToDisk!.RunOrStop(index, running);
                  });
                },
                    (Task){
                  setState(() {
                    expand=!expand;
                    taskname=Task;
                  });
                }
            ):ExpandWork(dataToDisk,taskname,(){
              setState((){
                expand=!expand;
              });
            })
                : NoTask(),
            floatingActionButton: FloatingActionButton.extended(
                onPressed: (){
                  AddNewTaskDialog(context).then((value) =>
                      addNewTask(value));
                },label: Text("+",style: StyleTextItem.stylelarge,)
            ),
          )
      );
  }
}
