// 本文件将所有可执行操作保存下来, 且配置各个页面的可用操作
// ignore_for_file: constant_identifier_names

final UserOptionConf userOptionConf = UserOptionConf();
final RegionsOptionConf regionsOptionConf = RegionsOptionConf();
final ShipuserOptionConf shipuserOptionConf = ShipuserOptionConf();
final CornucopaOptionConf cornucopaOptionConf = CornucopaOptionConf();
final SeasonOptConf seasonOptConf = SeasonOptConf();
final RuinsOptConf ruinsOptConf = RuinsOptConf();
final RuinsRegistOptConf registOptConf = RuinsRegistOptConf();

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
  static const String MODY_PAWD = 'modi_passwd';
  static const String RESET_PAWD = 'reset_passwd';

  // 用户管理页可执行操作
  static const List<String> _userOptionPageOptions = [
    APPROVE,
    REFUSE,
    // DEMOTE,
    UPDATE,
    // FORBIDDEN,
    SET_ROLES,
    RESET_PAWD,
    LOGOUT,
  ];
  // 用户编辑页可执行操作
  static const List<String> _userEditPageOptions = [LOGOFF, MODY_PAWD];

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
  static const String Add = 'new_add';

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
  // OPEN_CORNUCOPIA 创建开盆计划
  // JOIN_CORNUCOPIA 加入开盆计划
  static const APPROVE = 'approve';
  static const DEMOTE = 'demote';
  static const FORBIDDEN = 'forbidden';
  static const LOGOUT = 'logout';
  static const DESIGNATE = 'designate';
  static const UPDATE = 'update';
  static const REMARK = 'remark';
  static const OPEN_CORNUCOPIA = 'open_cornucopia';
  static const JOIN_CORNUCOPIA = 'join_cornucopia';

  // 角色管理页可执行操作
  static const List<String> _userOptionPageOptions = [
    APPROVE,
    // DEMOTE,
    // FORBIDDEN,
    DESIGNATE,
    REMARK,
    LOGOUT,
    UPDATE,
    // OPEN_CORNUCOPIA,  # 暂时不做聚宝盆数据了
    // JOIN_CORNUCOPIA,
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
class CornucopaOptionConf {
  // DISUSE = 'disuse'  # 废除开盆计划
  // OPEN = 'open'  # 执行开盆
  // END = 'end'  # 开盆7天后自动结束
  // JOIN = 'join'  # 参盆
  static const DISUSE = 'disuse';
  static const OPEN = 'open';
  static const END = 'end';
  static const JOIN = 'join';

  static const List<String> _all = [DISUSE, OPEN, END, JOIN];

  bool optionIsValid(String option) {
    return _all.contains(option);
  }
}

// 对赛季操作
class SeasonOptConf {
  // APPROVE = 'approve'  # 管理员审核通过新用户
  // END = 'end'  # 赛季结束

  static const String APPROVE = 'approve';
  static const String END = 'end';

  // 用户管理页可执行操作
  static const List<String> _OptionPageOptions = [
    APPROVE,
    END,
  ];
  // 用户编辑页可执行操作
  static const List<String> _EditPageOptions = [];

  bool optionInOptionPage(String option) {
    return _OptionPageOptions.contains(option);
  }

  bool optionInEditPage(String option) {
    return _EditPageOptions.contains(option);
  }
}

class RuinsOptConf {
  // NEW_ADD = 'new_add'
  // START = 'start'
  // PROCESS = 'process'
  // END = 'end'
  // CLOSE = 'close'
  static const START = 'start';
  static const PROCESS = 'process';
  static const END = 'end';
  static const CLOSE = 'close';
  static const UPDATE = 'update';
  static const DELETE = 'delete';

  static const List<String> _all_options = [
    START,
    PROCESS,
    END,
    CLOSE,
    UPDATE,
    DELETE,
  ];

  bool optionIsValid(String option) {
    return _all_options.contains(option);
  }
}

class RuinsRegistOptConf {
  // NEW_ADD = 'new_add'
  // APPROVE = 'approve'
  // REFUSE = 'refuse'
  // CANCEL = 'cancel'
  // COMPLETE = 'complete'
  static const APPROVE = 'approve';
  static const REFUSE = 'refuse';
  static const CANCEL = 'cancel';
  static const COMPLETE = 'complete';
  static const List<String> _all_options = [
    APPROVE,
    REFUSE,
    CANCEL,
    COMPLETE,
  ];

  bool optionIsValid(String option) {
    return _all_options.contains(option);
  }
}
