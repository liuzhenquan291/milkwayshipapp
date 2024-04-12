import 'package:milkwayshipapp/core/models/options_model.dart';
import 'package:milkwayshipapp/core/models/ship_user_model.dart';

import '../utils.dart';

class RegionModel {
  String id;
  String number;
  DateTime createdTime;
  String updatedTime;
  bool deleted;
  String status;
  String statusName;
  String name;
  String nameFmt;
  String zoneInfo;
  String desc;
  String createUserId;
  ShipUserModel? commander;
  String? color;
  List<ShipUserModel>? shipUsers;
  List<OptionModel>? options; // TODO: options

  RegionModel({
    required this.id,
    required this.number,
    required this.createdTime,
    required this.updatedTime,
    required this.deleted,
    required this.status,
    required this.name,
    required this.nameFmt,
    required this.zoneInfo,
    required this.desc,
    required this.createUserId,
    required this.statusName,
    this.commander,
    this.shipUsers,
    this.options,
    this.color,
  });

  factory RegionModel.fromJson(Map<String, dynamic> json) {
    return RegionModel(
      id: json['id'] ?? '',
      number: json['number'] ?? '',
      createdTime: DateTime.parse(json['created_time']),
      updatedTime: json['updated_time'],
      deleted: json['deleted'] ?? false,
      status: json['status'] ?? '',
      name: json['name'] ?? '',
      nameFmt: json['name_fmt'] ?? '',
      zoneInfo: json['zone_info'] ?? '',
      desc: json['desc'] ?? '',
      createUserId: json['create_user_id'] ?? '',
      color: json['color'] ?? "红色",
      statusName: json['status_name'] ?? "",
      commander: json['commander'] != null
          ? ShipUserModel.fromJson(json['commander'] ?? {})
          : null,
      shipUsers: json['ship_users'] != null
          ? ShipUserModel.fromJsonToList(json['ship_users'] ?? [])
          : null,
      options: json['options'] != null
          ? OptionModel.fromJsonToList(json['options'] ?? [])
          : null,
    );
  }

  static List<RegionModel> fromJsonToList(List<dynamic>? list) {
    if (list == null || list.isEmpty) {
      return [];
    }
    List<RegionModel> lst = [];
    for (var element in list) {
      lst.add(RegionModel.fromJson(element));
    }
    return lst;
  }

  String getCreatedTime() {
    return formatDateTime_1(createdTime);
  }
}
