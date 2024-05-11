import '../utils.dart';
import 'options_model.dart';
import 'register_model.dart';

class RuinGroupSchedule {
  String? id;
  String? groupId;
  String? scheduleName;
  DateTime? createdTime;
  String? updatedTime;
  bool? deleted;
  DateTime? startTime;
  DateTime? endTime;
  int? targetScore;
  RuinGroupSchedule({
    this.id,
    this.groupId,
    this.scheduleName,
    this.createdTime,
    this.updatedTime,
    this.deleted,
    this.startTime,
    this.endTime,
    this.targetScore,
  });
  factory RuinGroupSchedule.fromJson(Map<String, dynamic> json) {
    return RuinGroupSchedule(
      id: json['id'],
      groupId: json['group_id'],
      scheduleName: json['schedule_name'],
      createdTime: json['created_time'] != null
          ? DateTime.parse(json['created_time'])
          : null,
      updatedTime: json['updated_time'],
      deleted: json['deleted'],
      startTime: json['start_time'] != null
          ? DateTime.parse(json['start_time'])
          : null,
      endTime:
          json['end_time'] != null ? DateTime.parse(json['end_time']) : null,
      targetScore: json['target_score'],
    );
  }
  static List<RuinGroupSchedule> fromJsonToList(List<dynamic>? list) {
    if (list == null || list.isEmpty) {
      return [];
    }
    List<RuinGroupSchedule> lst = [];
    list.forEach((element) {
      lst.add(RuinGroupSchedule.fromJson(element));
    });
    return lst;
  }

  String getCreatedTime() {
    return formatDateTime_1(createdTime);
  }

  String getStartTime() {
    if (startTime == null) {
      return "";
    }
    return formatDateTime_3(startTime);
  }

  String getEndTime() {
    if (endTime == null) {
      return "";
    }
    return formatDateTime_3(endTime);
  }
}

class RuinGroupModel {
  String? id;
  String? groupName;
  int? targetShipuserCnt;
  int? actualShipuserCnt;
  DateTime? createdTime;
  String? updatedTime;
  bool? deleted;
  String? scoreDesc;
  List<OptionModel>? options;
  List<RuinGroupSchedule>? schedules;
  List<RuinRegisterModel>? registers;

  RuinGroupModel({
    this.id,
    this.groupName,
    this.targetShipuserCnt,
    this.actualShipuserCnt,
    this.createdTime,
    this.updatedTime,
    this.deleted,
    this.options,
    this.schedules,
    this.registers,
    this.scoreDesc,
  });
  factory RuinGroupModel.fromJson(Map<String, dynamic> json) {
    return RuinGroupModel(
      id: json['id'] ?? '',
      groupName: json['group_name'],
      targetShipuserCnt: json['target_shipuser_cnt'],
      actualShipuserCnt: json['actual_shipuser_cnt'],
      createdTime: json['created_time'] != null
          ? DateTime.parse(json['created_time'])
          : null,
      updatedTime: json['updated_time'] ?? "",
      deleted: json['deleted'] ?? false,
      scoreDesc: json['score_desc'] ?? "",
      options: json['options'] != null
          ? OptionModel.fromJsonToList(json['options'] ?? [])
          : [],
      schedules: json['schedules'] != null
          ? RuinGroupSchedule.fromJsonToList(json['schedules'] ?? [])
          : [],
      registers: json['registers'] != null
          ? RuinRegisterModel.fromJsonToList(json['registers'] ?? [])
          : [],
    );
  }

  static List<RuinGroupModel> fromJsonToList(List<dynamic>? list) {
    if (list == null || list.isEmpty) {
      return [];
    }
    List<RuinGroupModel> lst = [];
    list.forEach((element) {
      lst.add(RuinGroupModel.fromJson(element));
    });
    return lst;
  }

  String getCreatedTime() {
    return formatDateTime_1(createdTime);
  }
}
