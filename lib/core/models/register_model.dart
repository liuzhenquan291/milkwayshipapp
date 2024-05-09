import 'ruins_group.dart';
import '../utils.dart';
import 'options_model.dart';

class RuinRegisterModel {
  String id;
  String number;
  DateTime createdTime;
  String updatedTime;
  bool deleted;
  String status;
  String statusName;

  String groupId;
  String shipuserId;
  String shipuserMskName;
  int score;
  RuinGroupModel? ruinGroup;

  List<OptionModel>? options;

  RuinRegisterModel({
    required this.id,
    required this.number,
    required this.createdTime,
    required this.updatedTime,
    required this.deleted,
    required this.status,
    required this.statusName,
    required this.groupId,
    required this.shipuserId,
    required this.shipuserMskName,
    required this.score,
    this.ruinGroup,
    this.options,
  });

  factory RuinRegisterModel.fromJson(Map<String, dynamic> json) {
    return RuinRegisterModel(
      id: json['id'] ?? '',
      number: json['number'] ?? '',
      createdTime: DateTime.parse(json['created_time']),
      updatedTime: json['updated_time'] ?? "",
      deleted: json['deleted'] ?? false,
      status: json['status'] ?? '',
      statusName: json['status_name'] ?? '',
      groupId: json['group_id'],
      shipuserId: json['ship_user_id'],
      shipuserMskName: json['ship_user_msk_name'],
      score: json['score'],
      ruinGroup: json['ruin_group'] != null
          ? RuinGroupModel.fromJson(json['ruin_group'] ?? {})
          : null,
      options: json['options'] != null
          ? OptionModel.fromJsonToList(json['options'] ?? [])
          : [],
    );
  }

  static List<RuinRegisterModel> fromJsonToList(List<dynamic>? list) {
    if (list == null || list.isEmpty) {
      return [];
    }
    List<RuinRegisterModel> lst = [];
    list.forEach((element) {
      lst.add(RuinRegisterModel.fromJson(element));
    });
    return lst;
  }

  String getCreatedTime() {
    return formatDateTime_1(createdTime);
  }
}
