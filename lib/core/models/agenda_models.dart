import 'user_model.dart';

class DepartmentalAgendaModel {
  String id;
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
}

class ShipuserDepartmentalInfoModel {
  String id;
  String shipUserId;
  String shipUserMksName;
  String agendaId;
  String agendaName;
  String skillAlive;
  String agendaLevel;
  String agendaNode;
  String propsLack;
  DateTime createdTime;
  String updatedTime;
  bool deleted;

  ShipuserDepartmentalInfoModel({
    required this.id,
    required this.shipUserId,
    required this.shipUserMksName,
    required this.agendaId,
    required this.agendaName,
    required this.skillAlive,
    required this.agendaLevel,
    required this.agendaNode,
    required this.propsLack,
    required this.createdTime,
    required this.updatedTime,
    required this.deleted,
  });

  factory ShipuserDepartmentalInfoModel.fromJson(Map<String, dynamic> json) {
    return ShipuserDepartmentalInfoModel(
      id: json['id'],
      shipUserId: json['ship_user_id'],
      shipUserMksName: json['ship_user_mks_name'],
      agendaId: json['agenda_id'],
      agendaName: json['agenda_name'],
      skillAlive: json['skill_alive'],
      agendaLevel: json['agenda_level'],
      agendaNode: json['agenda_node'],
      propsLack: json['props_lack'],
      createdTime: DateTime.parse(json['created_time']),
      updatedTime: json['updated_time'],
      deleted: json['deleted'] ?? false,
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
