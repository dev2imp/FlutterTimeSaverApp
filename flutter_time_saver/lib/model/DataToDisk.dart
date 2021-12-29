import 'package:flutter_time_saver/model/KeyDataModel.dart';
import 'package:flutter_time_saver/model/SaveDataModel.dart';
import 'package:flutter_time_saver/model/TimeDate.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';
import 'dart:io';
class DataToDisk{
  List<KeyDataModel> UserData = [];
  Map<String,List<SaveDataModel>> UserHashData = Map();
  Function TrigerLoad;//CallBack function after data is read from disk we simply setstate again in main statefullwidget
  DataToDisk(this.TrigerLoad){
    ReadFromDisk();
  }
  TimeDate timeDate=TimeDate();
  double time=0;
  RunOrStop(index,running){
    if(running=="true"){
      //user want to run clicked tem
      if(UserData.elementAt(0).Running=="true"){
        //there is a task running in in first item
        // we have to save time for item that was already running
        //updte running state of index 0 and remove index and 0 both
        //here I dont check if index ==0 no need it here,
        UserData.elementAt(0).Running=false.toString();
        UserHashData[UserData.elementAt(0).taskName]!.elementAt(0).Running=false.toString();
        KeyDataModel firstItem=UserData.elementAt(0);
        KeyDataModel indexItem=UserData.elementAt(index);
        UserData.removeAt(0);
        UserData.removeAt(index-1);
        //insert by index
        UserData.insert(0, indexItem);
        UserData.insert(index, firstItem);
        UserData.elementAt(0).Running="true";
        UserHashData[UserData.elementAt(0).taskName]!.elementAt(0).Running=true.toString();
        SaveTimeNow();
      }
      else{ //no task was run before
        SaveTimeNow();//save time right now to prefs
        if(index!=0){
          KeyDataModel firstItem=UserData.elementAt(0);
          KeyDataModel indexItem=UserData.elementAt(index);
          UserData.removeAt(0);
          UserData.removeAt(index-1);
          UserData.insert(0, indexItem);
          UserData.insert(index, firstItem);
        }
        UserData.elementAt(0).Running=true.toString();
        UserHashData[UserData.elementAt(0).taskName]!.elementAt(0).Running=true.toString();
      }
    }else{//  user want to stop running task // our running task is always at index 0
      StopTaskAndSave(index);
      UserData.elementAt(0).Running=false.toString();
      UserHashData[UserData.elementAt(0).taskName]!.elementAt(0).Running=false.toString();
    }
    SaveDataToDisk();
  }
  StopTaskAndSave(index) async{
    //there will be always on task running in our app which is first one.
    double nowSeconds =timeDate.DateTimeToSecond(timeDate.TimeNow()) ;
    double beforeSecond= await timeDate.GetSecondFromPref() ;
    time= nowSeconds - beforeSecond;
    String timeFormat=timeDate.GetTimeFormat(time);
    DateTime now= DateTime.now();
    SaveDataModel saveDataModel = SaveDataModel(now.year.toString(), now.month.toString(), now.day.toString(),
        now.hour.toString(), now.minute.toString(),
        timeFormat, false.toString(), UserData.elementAt(index).taskName.toString());
    PutToHashMap(UserData.elementAt(index).taskName,saveDataModel);
  }
  PutToHashMap(work,SaveDataModel saveDataModel){
   if(UserHashData.containsKey(work)){
     UserHashData[work]?.add(saveDataModel);
    }else{
     List<SaveDataModel> list=[];
     list.add(SaveDataModel(
         saveDataModel.Year.toString(), saveDataModel.Month.toString(), saveDataModel.Day.toString(),
         saveDataModel.Hour.toString(), saveDataModel.Minute.toString(), "0:0:0", saveDataModel.Running.toString(), work));
     UserHashData.putIfAbsent(work, () => list);
   }
  }
  SaveTimeNow(){
    timeDate.SaveTimeNow();
  }
  void RemoveItemAt(index){
    UserHashData.remove(UserData.elementAt(index).taskName);
    UserData.removeAt(index);
    SaveDataToDisk();
  }
  void updateData(String newTask){
    KeyDataModel keyDataModel =KeyDataModel(newTask, false.toString());
    UserData.add(keyDataModel);
    //add to hashmap too:
    DateTime now = DateTime.now();
    List<SaveDataModel> list=[];
    list.add(SaveDataModel(
        now.year.toString(), now.month.toString(), now.day.toString(),
        now.hour.toString(), now.minute.toString(), "0:0:0", false.toString(), newTask));
    UserHashData.putIfAbsent(newTask, () => list);
    SaveDataToDisk();
    ReadFromDisk();
  }
  ReadFromDisk() async{

    File file=File(await getFilePath());
    String string=await file.readAsString();
    dynamic  parsedJson=jsonDecode(string);
    print("ReadFromDisk");
    print(parsedJson);
    UserHashData =Map();
    for(String key in parsedJson.keys){//get all keys from Json file
      for(dynamic value in parsedJson[key]){
        PutToHashMap(key,SaveDataModel(
            value['year'],value['month'] ,value['day'] ,value['hour'] ,
            value['minute']  ,value['totalWork'],value['running'] ,value['work']
        ));
      }
    }
    UserData=[];
    for(String key in UserHashData.keys){
      KeyDataModel keyDataModel= KeyDataModel(
          UserHashData[key]!.elementAt(0).Work,
          UserHashData[key]!.elementAt(0).Running);
      if(UserHashData[key]!.elementAt(0).Running == true.toString()){
        UserData.insert(0, keyDataModel);
      }else{
        UserData.add(keyDataModel);
      }
    }
    TrigerLoad();
  }
  SaveDataToDisk() async{
    //we will write hashmap to disk
    File file =File(await getFilePath());
    file.writeAsString(json.encode(UserHashData));
  }
  Future<String> getFilePath() async {
    Directory appDocumentsDirectory = await getApplicationDocumentsDirectory(); // 1
    String appDocumentsPath = appDocumentsDirectory.path; // 2
    String filePath = '$appDocumentsPath/appdata.json'; // 3
    return filePath;
  }
}