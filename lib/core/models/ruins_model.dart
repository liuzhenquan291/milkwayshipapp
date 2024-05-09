import 'package:milkwayshipapp/core/models/user_model.dart';

import '../utils.dart';
import 'options_model.dart';

class RuinsModel {
  String id;
  String number;
  DateTime createdTime;
  String updatedTime;
  bool deleted;
  DateTime? startTime;
  DateTime? endTime;
  String status;
  String statusName;

  String createUserId;
  int? targetShipUserCnt;
  int? actualShipUserCnt;
  int? outerCnt;
  int? middleCnt;
  int? innerCnt;
  bool ruinOwner;

  UserModel? creator;

  List<OptionModel>? options;

  RuinsModel({
    required this.id,
    required this.number,
    required this.createdTime,
    required this.updatedTime,
    required this.deleted,
    this.startTime,
    this.endTime,
    required this.status,
    required this.statusName,
    required this.createUserId,
    this.targetShipUserCnt,
    this.actualShipUserCnt,
    this.outerCnt,
    this.middleCnt,
    this.innerCnt,
    required this.ruinOwner,
    this.creator,
    this.options,
  });

  factory RuinsModel.fromJson(Map<String, dynamic> json) {
    return RuinsModel(
      id: json['id'] ?? '',
      number: json['number'] ?? '',
      createdTime: DateTime.parse(json['created_time']),
      updatedTime: json['updated_time'] ?? "",
      deleted: json['deleted'] ?? false,
      startTime: json['start_time'],
      endTime: json['end_time'],
      status: json['status'] ?? '',
      statusName: json['status_name'] ?? '',
      createUserId: json['create_user_id'] ?? '',
      targetShipUserCnt: json['target_shipuser_cnt'],
      actualShipUserCnt: json['actual_shipuser_cnt'],
      outerCnt: json['outer_cnt'],
      middleCnt: json['middle_cnt'],
      innerCnt: json['inner_cnt'],
      ruinOwner: json['ruin_owner'],
      creator: json['creator'] != null
          ? UserModel.fromJson(json['creator'] ?? {})
          : null,
      options: json['options'] != null
          ? OptionModel.fromJsonToList(json['options'] ?? [])
          : [],
    );
  }

  static List<RuinsModel> fromJsonToList(List<dynamic>? list) {
    if (list == null || list.isEmpty) {
      return [];
    }
    List<RuinsModel> lst = [];
    list.forEach((element) {
      lst.add(RuinsModel.fromJson(element));
    });
    return lst;
  }

  String getCreatedTime() {
    return formatDateTime_1(createdTime);
  }
}
