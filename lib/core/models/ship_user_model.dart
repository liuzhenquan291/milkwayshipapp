import 'package:milkwayshipapp/core/models/options_model.dart';
import 'package:milkwayshipapp/core/models/region_model.dart';
import 'package:milkwayshipapp/core/models/ship_cornucopia_model.dart';
import 'package:milkwayshipapp/core/models/user_model.dart';

class ShipUserModel {
  String id;
  bool needCornucopia;
  bool canCornucopia;
  String needCornucopiaTime;
  String canCornucopiaTime;
  String number;
  DateTime createdTime;
  DateTime updatedTime;
  bool deleted;
  String status;
  String statusName;
  String userId;
  String mksUuid;
  String mksName;
  String regionsId;
  String regionsRole;
  String? regionsRoleName;
  DateTime? lastJoinRegionTime;
  DateTime? lastOpenRegionTime;

  UserModel? user; // 用户
  RegionModel? region; // 势力
  List<OptionModel>? options; // 可执行的操作
  List<ShipCornucopiaModel>? cornucopias; // 开盆/投盆记录
  List<ShipCornucopiaModel>? toJoinCornucopias; // 可参加的聚宝盆

  ShipUserModel({
    required this.id,
    required this.needCornucopia,
    required this.canCornucopia,
    required this.needCornucopiaTime,
    required this.canCornucopiaTime,
    required this.number,
    required this.createdTime,
    required this.updatedTime,
    required this.deleted,
    required this.status,
    required this.statusName,
    required this.userId,
    required this.mksUuid,
    required this.mksName,
    required this.regionsId,
    required this.regionsRole,
    this.regionsRoleName,
    this.lastJoinRegionTime,
    this.lastOpenRegionTime,
    this.user,
    this.region,
    this.options,
    this.cornucopias,
    this.toJoinCornucopias,
  });

  factory ShipUserModel.fromJson(Map<String, dynamic> json) {
    return ShipUserModel(
      id: json['id'] ?? '',
      needCornucopia: json['need_cornucopia'] ?? false,
      canCornucopia: json['can_cornucopia'] ?? false,
      needCornucopiaTime: json['need_cornucopia_time'] ?? '',
      canCornucopiaTime: json['can_cornucopia_time'] ?? '',
      number: json['number'] ?? '',
      createdTime: DateTime.parse(json['created_time']),
      updatedTime: DateTime.parse(json['updated_time']),
      deleted: json['deleted'] ?? false,
      status: json['status'] ?? '',
      statusName: json['status_name'] ?? '',
      userId: json['user_id'] ?? '',
      mksUuid: json['mks_uuid'] ?? '',
      mksName: json['mks_name'] ?? '',
      regionsId: json['regions_id'] ?? '',
      regionsRole: json['regions_role'] ?? '',
      regionsRoleName: json['regions_role_name'] ?? '',
      region: json['region'] != null
          ? RegionModel.fromJson(json['region'] ?? {})
          : null,
      lastJoinRegionTime: json['last_join_region_time'] != null
          ? DateTime.parse(json['last_join_region_time'])
          : null,
      lastOpenRegionTime: json['last_open_region_time'] != null
          ? DateTime.parse(json['last_open_region_time'])
          : null,
      user:
          json['user'] != null ? UserModel.fromJson(json['user'] ?? {}) : null,
      options: json['options'] != null
          ? OptionModel.fromJsonToList(json['options'] ?? [])
          : [],
      cornucopias: json['cornucopias'] != null
          ? ShipCornucopiaModel.fromJsonToList(json['cornucopias'] ?? [])
          : [],
      toJoinCornucopias: json['to_join_options'] != null
          ? ShipCornucopiaModel.fromJsonToList(json['to_join_options'] ?? [])
          : [],
    );
  }

  static List<ShipUserModel> fromJsonToList(List<dynamic>? list) {
    if (list == null || list.isEmpty) {
      return [];
    }
    List<ShipUserModel> lst = [];
    list.forEach((element) {
      lst.add(ShipUserModel.fromJson(element));
    });
    return lst;
  }
}
