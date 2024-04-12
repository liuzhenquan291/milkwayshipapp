import 'package:milkwayshipapp/core/models/region_model.dart';
import 'package:milkwayshipapp/core/models/ship_user_model.dart';

import '../utils.dart';
import 'options_model.dart';

class ShipCornucopiaModel {
  String id;
  String number;
  DateTime createdTime;
  String updatedTime;
  // bool deleted;
  String status;
  String? statusName;
  DateTime? scheduleTime;
  DateTime? startTime;
  DateTime? endTime;
  String operateUserId;
  String operateShipUserId;
  String regionsId;
  String? action;
  int? appliCount;
  int? joinedCount;
  ShipUserModel? shipuser;
  RegionModel? regions;
  String? appliTime; // 申请加入时间--- //TODO: 是否建一个 cornucopiaRecordModel
  bool ifJoined;
  bool ifMissed;
  List<ShipUserModel>? joinedShipUsers; // 已参盆角色
  List<ShipUserModel>? toJoinShipUsers; // 可参盆角色
  List<OptionModel>? options; // TODO: options

  ShipCornucopiaModel({
    required this.id,
    required this.number,
    required this.createdTime,
    required this.updatedTime,
    // required this.deleted,
    required this.status,
    this.scheduleTime,
    this.startTime,
    this.endTime,
    required this.operateUserId,
    required this.operateShipUserId,
    required this.regionsId,
    this.statusName,
    this.action,
    this.appliCount,
    this.joinedCount,
    this.shipuser,
    this.regions,
    this.appliTime,
    required this.ifJoined,
    required this.ifMissed,
    this.joinedShipUsers,
    this.toJoinShipUsers,
    this.options,
  });

  factory ShipCornucopiaModel.fromJson(Map<String, dynamic> json) {
    return ShipCornucopiaModel(
      id: json['id'] ?? '',
      number: json['number'] ?? '',
      createdTime: DateTime.parse(json['created_time']),
      updatedTime: json['updated_time'],
      // deleted: json['deleted'] ?? false,
      status: json['status'] ?? '',
      statusName: json['status_name'] ?? '',
      scheduleTime: json['schedule_time'] != null
          ? DateTime.parse(json['schedule_time'])
          : null,
      startTime: json['start_time'] != null
          ? DateTime.parse(json['start_time'])
          : null,
      endTime:
          json['end_time'] != null ? DateTime.parse(json['end_time']) : null,
      operateUserId: json['operate_user_id'] ?? '',
      operateShipUserId: json['ship_user_id'] ?? '',
      regionsId: json['regions_id'] ?? '',
      action: json['action'] ?? '',
      appliCount: json['appli_count'] ?? 0,
      joinedCount: json['joined_count'] ?? 0,
      shipuser: json['shipuser'] != null
          ? ShipUserModel.fromJson(json['shipuser'] ?? {})
          : null,
      regions: json['regions'] != null
          ? RegionModel.fromJson(json['regions'] ?? {})
          : null,
      appliTime: json['appli_time'],
      ifJoined: json['if_joined'] ?? false,
      ifMissed: json['if_missed'] ?? false,
      joinedShipUsers: json['joined_shipusers'] != null
          ? ShipUserModel.fromJsonToList(json['joined_shipusers'] ?? {})
          : [],
      toJoinShipUsers: json['to_join_shipusers'] != null
          ? ShipUserModel.fromJsonToList(json['to_join_shipusers'] ?? {})
          : [],
      options: json['options'] != null
          ? OptionModel.fromJsonToList(json['options'] ?? {})
          : null,
    );
  }

  static List<ShipCornucopiaModel> fromJsonToList(List<dynamic>? list) {
    if (list == null || list.isEmpty) {
      return [];
    }
    List<ShipCornucopiaModel> lst = [];
    for (var element in list) {
      lst.add(ShipCornucopiaModel.fromJson(element));
    }
    return lst;
  }

  String getCreatedTime() {
    return formatDateTime_1(createdTime);
  }

  String getStartTime() {
    return formatDateTime_1(startTime);
  }

  String getEndTime() {
    return formatDateTime_1(endTime);
  }

  String getScheduleTime() {
    return formatDateTime_1(scheduleTime);
  }
}
