import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TimeDate{
  DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
  dynamic currentTime = DateFormat.jm().format(DateTime.now());
  DateTime now = DateTime.now();
  DateTime TimeNow(){
    now = DateTime.now();
    return now;
  }
  SaveTimeNow() async {
    now = DateTime.now();
    final prefs = await SharedPreferences.getInstance();
   double seconds= DateTimeToSecond(now);
   prefs.setDouble('seconds', seconds);
  }
  Future<double> GetSecondFromPref() async {
    final prefs = await SharedPreferences.getInstance();
    final double seconds = prefs.getDouble('seconds') ?? 0;
    return seconds;
  }
  String GetTimeFormat(double seconds){
    int hour= (seconds/3600).toInt();
    int minute= ((seconds%3600)/60).toInt();
    var second= (seconds%60).toInt();
    return hour.toInt().toString()+":"+minute.toString()+":"+second.toString();
  }
 double DateTimeToSecond(DateTime now){
    double seconds=0;
    seconds=now.minute*60;
    seconds= seconds + now.hour*3600;
    seconds= seconds + now.day*86400;
    seconds= seconds + now.month*86400*30;
    seconds= seconds + now.year*86400*30*12;
    return seconds;
  }
}


