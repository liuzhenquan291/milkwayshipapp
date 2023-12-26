class RegionDetailModel {
  String? id;
  String? name;
  String? number;
  String? status;
  String? nameFmt;
  String? zoneInfo;
  String? desc;
  String? createUserId;
  String? createdTime;
  String? updatedTime;
  String? commander;
  String? color;
  List<dynamic>? options;
  List<dynamic>? shipUsers;

  RegionDetailModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    number = json['number'];
    status = json['number'];
    commander = json['commander'];
    color = json['color'];
    nameFmt = json['name_fmt'];
    zoneInfo = json['zone_info'];
    desc = json['desc'];
    createUserId = json['create_user_id'];
    createdTime = json['created_time'];
    updatedTime = json['updated_time'];
    final _options = json['options'];
    if (_options == null) {
      options = [];
    } else {
      options = _options;
    }
    options = json['options'];
    final _shipUsers = json['ship_users'];
    if (_shipUsers == null) {
      shipUsers = [];
    } else {
      shipUsers = _shipUsers;
    }
  }
}
