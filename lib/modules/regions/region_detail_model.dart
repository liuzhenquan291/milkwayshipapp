class RegionDetailModel {
  String? id;
  String? name;
  List<dynamic>? shipUsers;

  RegionDetailModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    shipUsers = json['ship_users'];
  }
}
