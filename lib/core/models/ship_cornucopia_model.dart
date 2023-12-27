import 'package:milkwayshipapp/core/models/ship_user_model.dart';

class ShipCornucopiaModel {
  String id;
  String number;
  DateTime createdTime;
  DateTime updatedTime;
  bool deleted;
  String status;
  DateTime? scheduleTime;
  DateTime? startTime;
  DateTime? endTime;
  String operateUserId;
  String operateShipUserId;
  String regionsId;
  ShipUserModel? shipuser;

  ShipCornucopiaModel({
    required this.id,
    required this.number,
    required this.createdTime,
    required this.updatedTime,
    required this.deleted,
    required this.status,
    this.scheduleTime,
    this.startTime,
    this.endTime,
    required this.operateUserId,
    required this.operateShipUserId,
    required this.regionsId,
    this.shipuser,
  });

  factory ShipCornucopiaModel.fromJson(Map<String, dynamic> json) {
    return ShipCornucopiaModel(
      id: json['id'] ?? '',
      number: json['number'] ?? '',
      createdTime: DateTime.parse(json['created_time']),
      updatedTime: DateTime.parse(json['updated_time']),
      deleted: json['deleted'] ?? false,
      status: json['status'] ?? '',
      scheduleTime: json['schedule_time'] != null
          ? DateTime.parse(json['schedule_time'])
          : null,
      startTime: json['start_time'] != null
          ? DateTime.parse(json['start_time'])
          : null,
      endTime:
          json['end_time'] != null ? DateTime.parse(json['end_time']) : null,
      operateUserId: json['operate_user_id'] ?? '',
      operateShipUserId: json['operate_ship_user_id'] ?? '',
      regionsId: json['regions_id'] ?? '',
      shipuser: json['shipuser'] != null
          ? ShipUserModel.fromJson(json['shipuser'] ?? {})
          : null,
    );
  }

  static List<ShipCornucopiaModel> fromJsonToList(List<dynamic>? list) {
    if (list == null || list.isEmpty) {
      return [];
    }
    List<ShipCornucopiaModel> lst = [];
    list.forEach((element) {
      lst.add(ShipCornucopiaModel.fromJson(element));
    });
    return lst;
  }
}
