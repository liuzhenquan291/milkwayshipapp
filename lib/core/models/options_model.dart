class OptionModel {
  String? code;
  String? name;
  String? title;

  OptionModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
    title = json['title'];
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
