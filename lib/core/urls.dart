const myIp = "192.168.162.92";

_ApiUrl apiUrl = _ApiUrl();

class _ApiUrl {
  final baseUrl = "http://$myIp:8008";

  //// 连接后端 user 应用
  final _userAppPath = "/user";
// 登录
  late final String userLoginPath;
// 注册、用户列表
  late final String useListCreatePath;
// 用户详情、更新、注销
  late final String userRetriveUpdateDestroyPath;
// 管理员审核通过用户申请
  late final String userApprove;
// 管理员禁用用户
  late final String userForbidden;
  // 管理员降级用户
  late final String userDemote;
// 设置用户身份
  late final String userSetRole;
// 获取用户的身份和对用户可执行的操作
  late final String userTotalOptions;

//// 连接后端 ship 应用
  late final String _shipAppPath = "/ship";
// 游戏角色创建、展示
  late final String shipUserListCreatePath;
// 游戏角色详情、更新、注销
  late final String shipUserRetriveUpdateDestroyPath;
// 管理员审核通过游戏角色
  late final String shipUserApprovePath;
// 设置为不活跃角色
  late final String shipUserDemotePath;
// 管理员禁用游戏角色
  late final String shipUserForbiddenPath;
// 管理员设置游戏角色身份
  late final String shipUserDesignatePath;
  // 设置用户标签
  late final String shipUserRemarkPath;
// 新建开盆计划、开盆计划列表
  late final String cornListCreatePath;
// 开盆计划  详情、更新、废除
  late final String cornucopiasRetrieveUpdateDestroyPath;
// 设置开盆计划已开盆
  late final String cornucopiasOpenedPath;
// 废除开盆计划
  late final String cornDisusePath;
// 申请加入开盆计划
  late final String cornucopiasJoinPath;
// 设置错过开盆
  late final String cornucopiasMissPath;
  // 成功参盆
  late final String cornJoinedPath;
  // 补参盆
  late final String cornLateJoinedPath;
// 聚宝盆综合信息
  late final String cornucopiaInfosPath;

//// 连接后端 region 应用
  late final String _regionAppPath = '/region';
// 注册势力、势力列表
  late final String regionsCreateListPath;
// 势力详情、更新、注销
  late final String regionsRetrieveUpdateDestroyPath;
// 根据 token 查询对应用户的势力信息
  late final String regionByUser;
// 管理员审核通过新势力申请
  late final String regionsApprovePath;
// 设置势力管理员
  late final String regionsSetManagerPath;

  _ApiUrl() {
    userLoginPath = "$_userAppPath/login/";
    useListCreatePath = "$_userAppPath/users/";
    userRetriveUpdateDestroyPath = "$_userAppPath/users/%s/";
    userApprove = "$_userAppPath/approve/";
    userForbidden = "$_userAppPath/forbidden/";
    userDemote = "$_userAppPath/demote/";
    userSetRole = "$_userAppPath/set_role/";
    userTotalOptions = "$_userAppPath/total_options/";
    shipUserListCreatePath = "$_shipAppPath/shipusers/";
    shipUserRetriveUpdateDestroyPath = "$_shipAppPath/shipusers/%s/";
    shipUserApprovePath = "$_shipAppPath/approve/";
    shipUserDemotePath = "$_shipAppPath/demote/";
    shipUserForbiddenPath = "$_shipAppPath/forbidden/";
    shipUserDesignatePath = "$_shipAppPath/designate/";
    shipUserRemarkPath = "$_shipAppPath/remark/";
    cornListCreatePath = "$_shipAppPath/cornucopias/";
    cornucopiasRetrieveUpdateDestroyPath = "$_shipAppPath/cornucopias/%s/";
    cornucopiasOpenedPath = "$_shipAppPath/cornucopias/open/";
    cornDisusePath = "$_shipAppPath/cornucopias/disuse/";
    cornucopiasJoinPath = "$_shipAppPath/cornucopias/join/";
    cornucopiasMissPath = "$_shipAppPath/cornucopias/miss/";
    cornJoinedPath = "$_shipAppPath/cornucopias/joined/";
    cornLateJoinedPath = "$_shipAppPath/cornucopias/late_joined/";
    cornucopiaInfosPath = "$_shipAppPath/cornucopia_infos/";
    regionsCreateListPath = "$_regionAppPath/regions/";
    regionsRetrieveUpdateDestroyPath = "$_regionAppPath/regions/%s/";
    regionsApprovePath = "$_regionAppPath/approve/";
    regionsSetManagerPath = "$_regionAppPath/set_manager/";
    regionByUser = "$_regionAppPath/regions/byuser/";
  }
}
