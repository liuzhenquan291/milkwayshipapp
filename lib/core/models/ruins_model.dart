import '../utils.dart';
import 'options_model.dart';
import 'ruins_group.dart';
import 'user_model.dart';

class RuinsModel {
  String? id;
  String? number;
  DateTime? createdTime;
  String? updatedTime;
  bool? deleted;
  DateTime? startTime;
  DateTime? endTime;
  String? status;
  String? statusName;

  String? createUserId;
  int? targetShipUserCnt;
  int? actualShipUserCnt;
  int? outerCnt;
  int? middleCnt;
  int? innerCnt;
  bool? ruinOwner;
  String? ruinOwnerName;

  UserModel? creator;

  List<OptionModel>? options;
  List<RuinGroupModel>? groups;

  RuinsModel({
    this.id,
    this.number,
    this.createdTime,
    this.updatedTime,
    this.deleted,
    this.startTime,
    this.endTime,
    this.status,
    this.statusName,
    this.createUserId,
    this.targetShipUserCnt,
    this.actualShipUserCnt,
    this.outerCnt,
    this.middleCnt,
    this.innerCnt,
    this.ruinOwner,
    this.creator,
    this.options,
    this.groups,
    this.ruinOwnerName,
  });

  factory RuinsModel.fromJson(Map<String, dynamic> json) {
    return RuinsModel(
      id: json['id'] ?? '',
      number: json['number'] ?? '',
      createdTime: json['created_time'] != null
          ? DateTime.parse(json['created_time'])
          : null,
      updatedTime: json['updated_time'] ?? "",
      deleted: json['deleted'] ?? false,
      startTime: json['start_time'] != null
          ? DateTime.parse(json['start_time'])
          : null,
      endTime:
          json['end_time'] != null ? DateTime.parse(json['end_time']) : null,
      status: json['status'] ?? '',
      statusName: json['status_name'] ?? '',
      createUserId: json['create_user_id'] ?? '',
      targetShipUserCnt: json['target_shipuser_cnt'],
      actualShipUserCnt: json['actual_shipuser_cnt'],
      outerCnt: json['outer_cnt'],
      middleCnt: json['middle_cnt'],
      innerCnt: json['inner_cnt'],
      ruinOwner: json['ruin_owner'],
      ruinOwnerName: json['ruin_owner_name'] ?? '',
      creator: json['creator'] != null
          ? UserModel.fromJson(json['creator'] ?? {})
          : null,
      options: json['options'] != null
          ? OptionModel.fromJsonToList(json['options'] ?? [])
          : [],
      groups: json['groups'] != null
          ? RuinGroupModel.fromJsonToList(json['groups'] ?? [])
          : [],
    );
  }

  static List<RuinsModel> fromJsonToList(List<dynamic>? list) {
    if (list == null || list.isEmpty) {
      return [];
    }
    List<RuinsModel> lst = [];
    list.forEach((element) {
      lst.add(RuinsModel.fromJson(element));
    });
    return lst;
  }

  String getCreatedTime() {
    return formatDateTime_1(createdTime);
  }

  String getStartTime() {
    return formatDateTime_3(startTime);
  }

  String getEndTime() {
    return formatDateTime_3(endTime);
  }

  Map<String, dynamic> toDictForUpdate() {
    return {
      'id': id,
      'number': number,
      'updated_time': updatedTime,
      'target_shipuser_cnt': targetShipUserCnt,
      'outer_cnt': outerCnt,
      'middle_cnt': middleCnt,
      'inner_cnt': innerCnt,
      'ruin_owner': ruinOwner,
      'start_time': startTime != null ? startTime!.toIso8601String() : null,
      'end_time': endTime != null ? endTime!.toIso8601String() : null,
      'groups': groups != null
          ? groups!.map((item) => item.toDictForUpdate()).toList().toList()
          : null
    };
  }

  Map<String, dynamic> toDictForCreate() {
    return {
      'number': number,
      'target_shipuser_cnt': targetShipUserCnt,
      'outer_cnt': outerCnt,
      'middle_cnt': middleCnt,
      'inner_cnt': innerCnt,
      'ruin_owner': ruinOwner,
      'start_time': startTime != null ? startTime!.toIso8601String() : null,
      'end_time': endTime != null ? endTime!.toIso8601String() : null,
      'groups': groups != null
          ? groups!.map((item) => item.toDictForCreate()).toList().toList()
          : null
    };
  }
}
