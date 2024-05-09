import '../utils.dart';
import 'options_model.dart';

class RuinGroupSchedule {
  String id;
  String groupId;
  String scheduleName;
  DateTime createdTime;
  String updatedTime;
  bool deleted;
  DateTime? startTime;
  DateTime? endTime;
  RuinGroupSchedule({
    required this.id,
    required this.groupId,
    required this.scheduleName,
    required this.createdTime,
    required this.updatedTime,
    required this.deleted,
    this.startTime,
    this.endTime,
  });
  factory RuinGroupSchedule.fromJson(Map<String, dynamic> json) {
    return RuinGroupSchedule(
        id: json['id'],
        groupId: json['group_id'],
        scheduleName: json['scheduleName'],
        createdTime: json['created_time'],
        updatedTime: json['updated_time'],
        deleted: json['deleted'],
        startTime: json['start_time'],
        endTime: json['end_time']);
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
}

class RuinGroupModel {
  String id;
  String groupName;
  int targetShipuserCnt;
  int actualShipuserCnt;
  DateTime createdTime;
  String updatedTime;
  bool deleted;
  List<OptionModel>? options;
  List<RuinGroupSchedule>? schedules;

  RuinGroupModel({
    required this.id,
    required this.groupName,
    required this.targetShipuserCnt,
    required this.actualShipuserCnt,
    required this.createdTime,
    required this.updatedTime,
    required this.deleted,
    this.options,
    this.schedules,
  });
  factory RuinGroupModel.fromJson(Map<String, dynamic> json) {
    return RuinGroupModel(
      id: json['id'] ?? '',
      groupName: json['group_name'],
      targetShipuserCnt: json['target_ship_user_cnt'],
      actualShipuserCnt: json['actual_ship_user_cnt'],
      createdTime: DateTime.parse(json['created_time']),
      updatedTime: json['updated_time'] ?? "",
      deleted: json['deleted'] ?? false,
      options: json['options'] != null
          ? OptionModel.fromJsonToList(json['options'] ?? [])
          : [],
      schedules: json['schedules'] != null
          ? RuinGroupSchedule.fromJsonToList(json['schedules'] ?? [])
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
