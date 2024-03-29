
class TaskModel {
  String? id;
  String? user;
  String? title;
  String? des;
  int? priority;
  String? date;
  bool? compelete;
  String? startTime;
  String? endTime;
  String? createdAt;
  String? updatedAt;
  bool? isRunning;
  String? diffTime;
  int? iV;

  TaskModel(
      {
      this.id,
      this.user,
      this.title,
      this.des,
      this.priority,
      this.date,
      this.compelete,
      this.startTime,
      this.endTime,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.diffTime,
      this.isRunning});

  TaskModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    user = json['user'];
    title = json['title'];
    des = json['des'];
    priority = json['priority'];
    date = json['date'];
    compelete = json['compelete'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    isRunning = json['is_running'];
    diffTime = json['diff_time'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['user'] = user;
    data['title'] = title;
    data['des'] = des;
    data['priority'] = priority;
    data['date'] = date;
    data['compelete'] = compelete;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['is_running'] = isRunning;
    data['diff_time'] = diffTime;
    data['__v'] = iV;
    return data;
  }

  Map<String,dynamic> forUpdateFields(){
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    data['compelete'] = compelete;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['is_running'] = isRunning;
    data['diff_time'] = diffTime;
    return data;
  }
}


//   "id": "6601faf430025c0129066640", 
//   "compelete": false, 
//   "start_time": "2024-03-26 12:57:06.027952", 
//   "end_time": "", 
//   "is_running": true, 
//   "diff_time": ""