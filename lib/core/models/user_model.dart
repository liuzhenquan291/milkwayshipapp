// ignore_for_file: avoid_function_literals_in_foreach_calls

import '../../core/models/options_model.dart';
import '../../core/models/ship_user_model.dart';

import '../utils.dart';

class UserModel {
  String id;
  DateTime? lastLogin;
  String number;
  DateTime createdTime;
  String updatedTime;
  bool deleted;
  String status;
  String statusName;
  String username;
  String displayName;
  String wechatName;
  String wcqName;
  String role;
  String roleName;
  String? encphone;
  int? shipUserCount;
  bool needInit;
  List<ShipUserModel>? shipUsers;
  List<OptionModel>? options;

  UserModel({
    required this.id,
    this.lastLogin,
    required this.number,
    required this.createdTime,
    required this.updatedTime,
    required this.deleted,
    required this.status,
    required this.statusName,
    required this.username,
    required this.displayName,
    required this.wechatName,
    required this.wcqName,
    required this.role,
    required this.roleName,
    required this.needInit,
    this.shipUsers,
    this.options,
    this.shipUserCount,
    this.encphone,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      lastLogin: json['last_login'] != null
          ? DateTime.parse(json['last_login'])
          : null,
      number: json['number'] ?? '',
      createdTime: DateTime.parse(json['created_time']),
      updatedTime: json['updated_time'] ?? "",
      deleted: json['deleted'] ?? false,
      status: json['status'] ?? '',
      statusName: json['status_name'] ?? '',
      username: json['username'] ?? '',
      displayName: json['display_name'] ?? '',
      wechatName: json['wechat_name'] ?? '',
      wcqName: json['wcq_name'] ?? '',
      role: json['role'] ?? '',
      roleName: json['role_name'] ?? '',
      needInit: json['need_init'] ?? false,
      shipUserCount: json['ship_user_count'] ?? 0,
      encphone: json['encphone'] ?? json['username'] ?? '',
      shipUsers: json['ship_users'] != null
          ? ShipUserModel.fromJsonToList(json['ship_users'] ?? [])
          : [],
      options: json['options'] != null
          ? OptionModel.fromJsonToList(json['options'] ?? [])
          : [],
    );
  }

  static List<UserModel> fromJsonToList(List<dynamic>? list) {
    if (list == null || list.isEmpty) {
      return [];
    }
    List<UserModel> lst = [];
    list.forEach((element) {
      lst.add(UserModel.fromJson(element));
    });
    return lst;
  }

  String getCreatedTime() {
    return formatDateTime_1(createdTime);
  }

  String getLastLoginTime() {
    return formatDateTime_1(lastLogin);
  }
}
