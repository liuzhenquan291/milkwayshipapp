// ignore_for_file: avoid_function_literals_in_foreach_calls

class OptionModel {
  String? code;
  String? name;
  String? title;

  OptionModel({
    this.code,
    this.name,
    this.title,
  });

  factory OptionModel.fromJson(Map<String, dynamic> json) {
    return OptionModel(
      code: json['code'],
      name: json['name'],
      title: json['title'],
    );
  }

  static List<OptionModel> fromJsonToList(List<dynamic>? list) {
    if (list == null || list.isEmpty) {
      return [];
    }
    List<OptionModel> lst = [];
    list.forEach((element) {
      lst.add(OptionModel.fromJson(element));
    });
    return lst;
  }
}

class TotalOptionModel {
  String? userId;
  String? userRole;
  String? optionsStr;
  List<OptionModel>? options;

  TotalOptionModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    userRole = json['user_role'];
    optionsStr = json['options_str'];
    options = json['options'] != null
        ? OptionModel.fromJsonToList(json['options'] ?? {})
        : [];
  }
}
