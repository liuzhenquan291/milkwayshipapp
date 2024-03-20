// 本文件将所有可执行操作保存下来, 且配置各个页面的可用操作
final UserOptionConf userOptionConf = UserOptionConf();
final RegionsOptionConf regionsOptionConf = RegionsOptionConf();
final ShipuserOptionConf shipuserOptionConf = ShipuserOptionConf();
final CornucopaOptionConf cornucopaOptionConf = CornucopaOptionConf();

// 对用户可执行的操作
class UserOptionConf {
  // APPROVE = 'approve'  # 管理员审核通过新用户
  // REFUSE = 'refuse'  # 拒绝用户申请
  // DEMOTE = 'demote'  # 降为不活跃用户
  // FORBIDDEN = 'forbidden'  # 禁用用户
  // LOGOUT = 'logout'  # 用户注销
  // SET_ROLES = 'set_roles'  # 设置用户角色

  // LOGOFF = 'logoff'  # 退出登录

  // UPDATE = 'update'
  static const String APPROVE = 'approve';
  static const String REFUSE = 'refuse';
  static const String DEMOTE = 'demote';
  static const String FORBIDDEN = 'forbidden';
  static const String LOGOUT = 'logout';
  static const String SET_ROLES = 'set_roles';
  static const String LOGOFF = 'logoff';
  static const String UPDATE = 'update';

  // 用户管理页可执行操作
  static const List<String> _userOptionPageOptions = [
    APPROVE,
    REFUSE,
    DEMOTE,
    FORBIDDEN
  ];
  // 用户编辑页可执行操作
  static const List<String> _userEditPageOptions = [LOGOFF, UPDATE, LOGOUT];

  bool optionInOptionPage(String option) {
    return _userOptionPageOptions.contains(option);
  }

  bool optionInEditPage(String option) {
    return _userEditPageOptions.contains(option);
  }
}

// 对势力可执行的操作
class RegionsOptionConf {
  // APPROVE = 'approve'  # 管理员审核通过新势力
  // REFUSE = 'refuse'  # 管理员拒绝新势力创建
  // LOGOUT = 'logout'  # 势力注销
  // SET_MANAGER = 'set_manager'  # 设置管理员
  // UPDATE = 'update'  # 编辑势力信息
  // JOIN = 'join'  # 加入势力
  static const String APPROVE = 'approve';
  static const String REFUSE = 'refuse';
  static const String LOGOUT = 'logout';
  static const String UPDATE = 'update';
  static const String SET_MANAGER = 'set_manager';
  static const String JOIN = 'join';

  // 势力管理页可执行操作
  static const List<String> _userOptionPageOptions = [
    APPROVE,
    REFUSE,
    SET_MANAGER,
    JOIN,
  ];
  // 势力编辑页可执行操作
  static const List<String> _userEditPageOptions = [UPDATE, LOGOUT];

  bool optionInOptionPage(String option) {
    return _userOptionPageOptions.contains(option);
  }

  bool optionInEditPage(String option) {
    return _userEditPageOptions.contains(option);
  }
}

// 对角色可执行的操作
class ShipuserOptionConf {
  // APPROVE = 'approve'  # 管理员审核通过新角色
  // DEMOTE = 'demote'  # 降为不活跃角色
  // FORBIDDEN = 'forbidden'  # 禁用角色
  // LOGOUT = 'logout'  # 用户注销
  // DESIGNATE = 'designate'  # 任命
  // UPDATE = 'update'  # 编辑信息
  // REMARK = 'remark'  # 标记
  static const APPROVE = 'approve';
  static const DEMOTE = 'demote';
  static const FORBIDDEN = 'forbidden';
  static const LOGOUT = 'logout';
  static const DESIGNATE = 'designate';
  static const UPDATE = 'update';
  static const REMARK = 'remark';

  // 角色管理页可执行操作
  static const List<String> _userOptionPageOptions = [
    APPROVE,
    DEMOTE,
    FORBIDDEN,
    DESIGNATE,
    REMARK,
  ];
  // 角色编辑页可执行操作
  static const List<String> _userEditPageOptions = [UPDATE, LOGOUT];

  bool optionInOptionPage(String option) {
    return _userOptionPageOptions.contains(option);
  }

  bool optionInEditPage(String option) {
    return _userEditPageOptions.contains(option);
  }
}

// 对聚宝盆可执行的操作
class CornucopaOptionConf {}
