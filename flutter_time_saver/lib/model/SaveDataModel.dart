class SaveDataModel {
  var Year="";
  var Month="";
  var Day="";
  var Hour="";
  var Minute="";
  var TotalWork="";
  var Running="";
  var Work="";
  SaveDataModel(this.Year,this.Month,this.Day,this.Hour,this.Minute,
  this.TotalWork,this.Running,this.Work);
  Map toJson(){
    return {'year':'$Year', 'month':'$Month', 'day':'$Day', 'hour':'$Hour', 'minute':'$Minute',
         'totalWork':'$TotalWork', 'running':'$Running', 'work':'$Work'};
  }
}
