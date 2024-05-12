import '../../core/models/options_model.dart';
import '../../core/models/user_model.dart';

import '../utils.dart';

class SeasonInfoModel {
  String id;
  String number;
  DateTime createdTime;
  String updatedTime;
  bool deleted;
  String status;
  String statusName;
  String name;
  int index;
  UserModel? creator;
  List<OptionModel>? options;

  SeasonInfoModel({
    required this.id,
    required this.number,
    required this.createdTime,
    required this.updatedTime,
    required this.deleted,
    required this.status,
    required this.statusName,
    required this.name,
    required this.index,
    this.creator,
    this.options,
  });

  factory SeasonInfoModel.fromJson(Map<String, dynamic> json) {
    return SeasonInfoModel(
      id: json['id'] ?? '',
      number: json['number'] ?? '',
      createdTime: DateTime.parse(json['created_time']),
      updatedTime: json['updated_time'],
      deleted: json['deleted'] ?? false,
      status: json['status'] ?? '',
      statusName: json['status_name'] ?? '',
      name: json['name'] ?? '',
      index: json['index'] ?? 0,
      creator: json['creator'] != null
          ? UserModel.fromJson(json['creator'] ?? {})
          : null,
      options: json['options'] != null
          ? OptionModel.fromJsonToList(json['options'] ?? [])
          : null,
    );
  }

  static List<SeasonInfoModel> fromJsonToList(List<dynamic>? list) {
    if (list == null || list.isEmpty) {
      return [];
    }
    List<SeasonInfoModel> lst = [];
    for (var element in list) {
      lst.add(SeasonInfoModel.fromJson(element));
    }
    return lst;
  }

  String getCreatedTime() {
    return formatDateTime_1(createdTime);
  }
}
