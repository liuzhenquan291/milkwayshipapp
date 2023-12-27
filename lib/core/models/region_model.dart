import 'package:milkwayshipapp/core/models/ship_user_model.dart';

class RegionModel {
  String id;
  String number;
  DateTime createdTime;
  DateTime updatedTime;
  bool deleted;
  String status;
  String name;
  String nameFmt;
  String zoneInfo;
  String desc;
  String createUserId;
  ShipUserModel? commander;

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
    this.commander,
  });

  factory RegionModel.fromJson(Map<String, dynamic> json) {
    return RegionModel(
      id: json['id'] ?? '',
      number: json['number'] ?? '',
      createdTime: DateTime.parse(json['created_time']),
      updatedTime: DateTime.parse(json['updated_time']),
      deleted: json['deleted'] ?? false,
      status: json['status'] ?? '',
      name: json['name'] ?? '',
      nameFmt: json['name_fmt'] ?? '',
      zoneInfo: json['zone_info'] ?? '',
      desc: json['desc'] ?? '',
      createUserId: json['create_user_id'] ?? '',
      commander: json['commander'] != null
          ? ShipUserModel.fromJson(json['commander'] ?? {})
          : null,
    );
  }

  static List<RegionModel> fromJsonToList(List<dynamic>? list) {
    if (list == null || list.isEmpty) {
      return [];
    }
    List<RegionModel> lst = [];
    list.forEach((element) {
      lst.add(RegionModel.fromJson(element));
    });
    return lst;
  }
}
