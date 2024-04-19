const myIp = "192.168.162.74";

ApiUrl apiUrl = ApiUrl();

//// 访问后端 user 应用
const _userApp = '/user';
//// 访问后端 ship 应用
const _shipApp = "/ship";
//// 访问后端 region 应用
const _regionApp = "/region";

class ApiUrl {
  final baseUrl = "http://$myIp:8008";

  //// 访问后端 user 应用
  // 登录
  String userLoginPath = "$_userApp/login/";
// 登录
  // String userLoginPath;
// 注册、用户列表
  String useListCreatePath = "$_userApp/users/";
// 用户详情、更新、注销
  String userRetriveUpdateDestroyPath = "$_userApp/users/%s/";
// 管理员审核通过用户申请
  String userApprove = "$_userApp/approve/";
// 管理员禁用用户
  String userForbidden = "$_userApp/forbidden/";
  // 管理员降级用户
  String userDemote = "$_userApp/demote/";
// 设置用户身份
  String userSetRole = "$_userApp/set_role/";
// 获取用户的身份和对用户可执行的操作
  String userTotalOptions = "$_userApp/total_options/";

//// 连接后端 ship 应用
// 游戏角色创建、展示
  String shipUserListCreatePath = "$_shipApp/shipusers/";
// 游戏角色详情、更新、注销
  String shipUserRetriveUpdateDestroyPath = "$_shipApp/shipusers/%s/";
// 管理员审核通过游戏角色
  String shipUserApprovePath = "$_shipApp/approve/";
// 设置为不活跃角色
  String shipUserDemotePath = "$_shipApp/demote/";
// 管理员禁用游戏角色
  String shipUserForbiddenPath = "$_shipApp/forbidden/";
// 管理员设置游戏角色身份
  String shipUserDesignatePath = "$_shipApp/designate/";
  // 设置用户标签
  String shipUserRemarkPath = "$_shipApp/remark/";
// 新建开盆计划、开盆计划列表
  String cornListCreatePath = "$_shipApp/cornucopias/";
// 开盆计划  详情、更新、废除
  String cornucopiasRetrieveUpdateDestroyPath = "$_shipApp/cornucopias/%s/";
// 设置开盆计划已开盆
  String cornucopiasOpenedPath = "$_shipApp/cornucopias/open/";
// 废除开盆计划
  String cornDisusePath = "$_shipApp/cornucopias/disuse/";
// 申请加入开盆计划
  String cornucopiasJoinPath = "$_shipApp/cornucopias/join/";
// 设置错过开盆
  String cornucopiasMissPath = "$_shipApp/cornucopias/miss/";
  // 成功参盆
  String cornJoinedPath = "$_shipApp/cornucopias/joined/";
  // 补参盆
  String cornLateJoinedPath = "$_shipApp/cornucopias/late_joined/";
// 聚宝盆综合信息
  String cornucopiaInfosPath = "$_shipApp/cornucopia_infos/";

//// 连接后端 region 应用
// 注册势力、势力列表
  String regionsCreateListPath = "$_regionApp/regions/";
// 势力详情、更新、注销
  String regionsRetrieveUpdateDestroyPath = "$_regionApp/regions/%s/";
  // 管理员审核通过新势力申请
  String regionsApprovePath = "$_regionApp/approve/";
  // 设置势力管理员
  String regionsSetManagerPath = "$_regionApp/set_manager/";
  // 根据 token 查询对应用户的势力信息
  String regionByUser = "$_regionApp/regions/byuser/";
}
