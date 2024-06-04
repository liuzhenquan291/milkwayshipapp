// ignore_for_file: avoid_function_literals_in_foreach_calls

import '../../core/models/options_model.dart';
import '../../core/models/region_model.dart';
import '../../core/models/ship_cornucopia_model.dart';
import '../../core/models/user_model.dart';

import '../utils.dart';

class ShipUserModel {
  String id;
  bool needCornucopia;
  bool canCornucopia;
  String needCornucopiaTime;
  String canCornucopiaTime;
  String number;
  DateTime createdTime;
  String updatedTime;
  bool deleted;
  String status;
  String statusName;
  String userId;
  String mksUuid;
  String mksName;
  String regionsId;
  String regionsRole;
  String? regionsRoleName;
  DateTime? lastJoinCornTime;
  DateTime? lastOpenCornTime;
  bool needInit;
  String? type;
  String? typeName;
  int? sword; // 战力
  String? swordName;
  int? toOpenSeconds;
  int? toJoinSeconds;

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
    required this.needInit,
    this.regionsRoleName,
    this.lastJoinCornTime,
    this.lastOpenCornTime,
    this.user,
    this.region,
    this.options,
    this.cornucopias,
    this.toJoinCornucopias,
    this.type,
    this.typeName,
    this.sword,
    this.swordName,
    this.toJoinSeconds,
    this.toOpenSeconds,
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
      updatedTime: json['updated_time'],
      deleted: json['deleted'] ?? false,
      status: json['status'] ?? '',
      statusName: json['status_name'] ?? '',
      userId: json['user_id'] ?? '',
      mksUuid: json['mks_uuid'] ?? '',
      mksName: json['mks_name'] ?? '',
      regionsId: json['regions_id'] ?? '',
      regionsRole: json['regions_role'] ?? '',
      regionsRoleName: json['regions_role_name'] ?? '',
      needInit: json['need_init'] ?? false,
      type: json['type'] ?? '',
      typeName: json['type_name'] ?? '',
      sword: json['sword'] ?? 0,
      swordName: json['sword_name'] ?? '',
      toOpenSeconds: json['to_open_seconds'] ?? 0,
      toJoinSeconds: json['to_join_seconds'] ?? 0,
      region: json['region'] != null
          ? RegionModel.fromJson(json['region'] ?? {})
          : null,
      lastJoinCornTime: json['last_join_corn_time'] != null
          ? DateTime.parse(json['last_join_corn_time'])
          : null,
      lastOpenCornTime: json['last_open_corn_time'] != null
          ? DateTime.parse(json['last_open_corn_time'])
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

  String getCreatedTime() {
    return formatDateTime_1(createdTime);
  }

  String getLastJoinCornTime() {
    return formatDateTime_3(lastJoinCornTime);
  }

  String getLastOpenCornTime() {
    return formatDateTime_3(lastOpenCornTime);
  }
}
