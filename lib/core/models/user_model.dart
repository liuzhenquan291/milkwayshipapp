import 'package:milkwayshipapp/core/models/options_model.dart';
import 'package:milkwayshipapp/core/models/ship_user_model.dart';

class UserModel {
  String id;
  DateTime? lastLogin;
  String number;
  DateTime createdTime;
  DateTime updatedTime;
  bool deleted;
  String status;
  String username;
  String displayName;
  String wechatName;
  String wcqName;
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
    required this.username,
    required this.displayName,
    required this.wechatName,
    required this.wcqName,
    this.shipUsers,
    this.options,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      lastLogin: json['last_login'] != null
          ? DateTime.parse(json['last_login'])
          : null,
      number: json['number'] ?? '',
      createdTime: DateTime.parse(json['created_time']),
      updatedTime: DateTime.parse(json['updated_time']),
      deleted: json['deleted'] ?? false,
      status: json['status'] ?? '',
      username: json['username'] ?? '',
      displayName: json['display_name'] ?? '',
      wechatName: json['wechat_name'] ?? '',
      wcqName: json['wcq_name'] ?? '',
      shipUsers: json['ship_users'] != null
          ? ShipUserModel.fromJsonToList(json['ship_users'] ?? [])
          : [],
      options: json['options'] != null
          ? OptionModel.fromJsonToList(json['options'] ?? [])
          : [],
    );
  }
}
