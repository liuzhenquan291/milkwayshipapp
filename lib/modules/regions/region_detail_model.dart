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
  List<String>? options;
  List<dynamic>? shipUsers;

  RegionDetailModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    number = json['number'];
    status = json['number'];
    nameFmt = json['name_fmt'];
    zoneInfo = json['zone_info'];
    desc = json['desc'];
    createUserId = json['create_user_id'];
    createdTime = json['created_time'];
    updatedTime = json['updated_time'];
    options = json['options'];
    shipUsers = json['ship_users'];
  }
}
