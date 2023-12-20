class UserListUserModel {
  String? userId;
  String? username;
  String? userDisplayName;
  String? wechatName;
  String? wcqName;
  String? status;
  String? statusName;
  String? userRole;
  String? options; // 可用操作

/*
"id" -> "de5e285673d041dba520dfef1338a40f"
"password" -> "123456"
"last_login" -> null
"is_superuser" -> false
"number" -> "U2311215823"
"created_time" -> "2023-11-21T17:27:42.221159"
"updated_time" -> "2023-11-21T17:27:42.221180"
"deleted" -> false
"status" -> "init"
"username" -> "18575546060"
"display_name" -> "蒙蕤"
"wechat_name" -> "蒙蕤"
*/

  UserListUserModel.fromJson(Map<String, dynamic> json) {
    userId = json['id'];
    username = json['username'];
    userDisplayName = json['display_name'];
    wechatName = json['wechat_name'];
    wcqName = json['wcq_name'];
    status = json['status'];
    statusName = json['status_name'];
    userRole = json['user_role'];
    options = json['operators'];
  }
}
