import 'package:milkwayshipapp/core/models/ship_user_model.dart';
import 'package:milkwayshipapp/core/utils.dart';

import 'user_model.dart';

class DepartmentalAgendaModel {
  int id;
  String name;
  String skill;
  String? skillEffect;
  String upgradeProps;
  String? upgradePropsName;
  String skillMajor;
  String? skillMajorName;
  DateTime createdTime;
  String updatedTime;
  bool deleted;
  UserModel? creator;
  List<ShipuserDepartmentalInfoModel>? shipUserDatas;
  // List<OptionModel>? options;

  DepartmentalAgendaModel({
    required this.id,
    required this.name,
    required this.skill,
    this.skillEffect,
    required this.upgradeProps,
    this.upgradePropsName,
    required this.skillMajor,
    this.skillMajorName,
    required this.createdTime,
    required this.updatedTime,
    required this.deleted,
    this.creator,
    this.shipUserDatas,
    // this.options,
  });

  factory DepartmentalAgendaModel.fromJson(Map<String, dynamic> json) {
    return DepartmentalAgendaModel(
      id: json['id'] ?? '',
      name: json['name'],
      skill: json['skill'],
      skillEffect: json['skill_effect'] ?? '',
      upgradeProps: json['upgrade_props'],
      skillMajor: json['skill_major'],
      skillMajorName: json['skill_major_name'],
      createdTime: DateTime.parse(json['created_time']),
      updatedTime: json['updated_time'],
      upgradePropsName: json['upgrade_props_name'],
      deleted: json['deleted'] ?? false,
      creator:
          json['creator'] != null ? UserModel.fromJson(json['creator']) : null,
      shipUserDatas: json['ship_user_datas'] != null
          ? ShipuserDepartmentalInfoModel.fromJsonToList(
              json['ship_user_datas'])
          : null,
      // options: json['options'] != null
      //     ? OptionModel.fromJsonToList(json['options'] ?? [])
      //     : null,
    );
  }

  static List<DepartmentalAgendaModel> fromJsonToList(List<dynamic>? list) {
    if (list == null || list.isEmpty) {
      return [];
    }
    List<DepartmentalAgendaModel> lst = [];
    list.forEach((element) {
      lst.add(DepartmentalAgendaModel.fromJson(element));
    });
    return lst;
  }

  String getCreatedDay() {
    return formatDateTime_2(createdTime);
  }
}

class ShipuserDepartmentalInfoModel {
  String? id;
  String shipUserId;
  String shipUserMksName;
  int? agendaId;
  String? agendaName;
  bool? skillAlive;
  String? skillAliveName;
  int agendaLevel;
  int agendaNode;
  int propsLack;
  DateTime? createdTime;
  String? updatedTime;
  bool? deleted;
  ShipUserModel? shipUser;

  ShipuserDepartmentalInfoModel({
    this.id,
    required this.shipUserId,
    required this.shipUserMksName,
    this.agendaId,
    this.agendaName,
    this.skillAlive,
    this.skillAliveName,
    required this.agendaLevel,
    required this.agendaNode,
    required this.propsLack,
    this.createdTime,
    this.updatedTime,
    this.deleted,
    this.shipUser,
  });

  factory ShipuserDepartmentalInfoModel.fromJson(Map<String, dynamic> json) {
    return ShipuserDepartmentalInfoModel(
      id: json['id'],
      shipUserId: json['ship_user_id'],
      shipUserMksName: json['ship_user_mks_name'],
      agendaId: json['agenda_id'],
      agendaName: json['agenda_name'],
      skillAlive: json['skill_alive'],
      skillAliveName: json['skill_alive_name'],
      agendaLevel: json['agenda_level'],
      agendaNode: json['agenda_node'],
      propsLack: json['props_lack'],
      createdTime: json['created_time'] != null
          ? DateTime.parse(json['created_time'])
          : null,
      updatedTime: json['updated_time'],
      deleted: json['deleted'] ?? false,
      shipUser: json['ship_user'] != null
          ? ShipUserModel.fromJson(json['ship_user'])
          : null,
    );
  }

  static List<ShipuserDepartmentalInfoModel> fromJsonToList(
      List<dynamic>? list) {
    if (list == null || list.isEmpty) {
      return [];
    }
    List<ShipuserDepartmentalInfoModel> lst = [];
    list.forEach((element) {
      lst.add(ShipuserDepartmentalInfoModel.fromJson(element));
    });
    return lst;
  }
}
