// 本文件将所有可执行操作保存下来, 且配置各个页面的可用操作

final optionConf = _OptionsConf();

class _OptionsConf {
  final UserOptionConf userOptionConf = UserOptionConf();
}

class UserOptionConf {
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
