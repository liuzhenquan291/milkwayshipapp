const baseUrl = "http://192.168.162.56:8008";

//// 连接后端 user 应用
const _userAppPath = "/user";
// 登录
const userLoginPath = "$_userAppPath/login/";
// 注册、用户列表
const useListCreatePath = "$_userAppPath/users/";
// 用户详情、更新、注销
const userRetriveUpdateDestroyPath = "$_userAppPath/users/%s/";
// 管理员审核通过用户申请
const userApprove = "$_userAppPath/approve/";
// 管理员禁用用户
const userForbidden = "$_userAppPath/forbidden/";
// 设置用户身份
const userSetRole = "$_userAppPath/set_role/";

//// 连接后端 ship 应用
const _shipAppPath = "/ship";
// 游戏角色创建、展示
const shipUserListCreatePath = "$_shipAppPath/shipusers/";
// 游戏角色详情、更新、注销
const shipUserRetriveUpdateDestroyPath = "$_shipAppPath/shipusers/%s/";
// 管理员审核通过游戏角色
const shipUserApprovePath = "$_shipAppPath/approve/";
// 管理员禁用游戏角色
const shipUserForbiddenPath = "$_shipAppPath/forbidden/";
// 管理员设置游戏角色身份
const shipUserSetRolePath = "$_shipAppPath/set_role/";
// 新建开盆计划、开盆计划列表
const cornucopiasListCreatePath = "$_shipAppPath/cornucopias/";
// 开盆计划  详情、更新、废除
const cornucopiasRetrieveUpdateDestroyPath = "$_shipAppPath/cornucopias/%s/";
// 设置开盆计划已开盆
const cornucopiasOpenedPath = "$_shipAppPath/cornucopias/opened/";
// 申请加入开盆计划
const cornucopiasJoinPath = "$_shipAppPath/cornucopias/join/";
// 设置错过开盆
const cornucopiasMissPath = "$_shipAppPath/cornucopias/miss/";

//// 连接后端 region 应用
const _regionAppPath = '/region';
// 注册势力、势力列表
const regionsCreateListPath = "$_regionAppPath/regions/";
// 势力详情、更新、注销
const regionsRetrieveUpdateDestroyPath = "$_regionAppPath/regions/%s/";
// 管理员审核通过新势力申请
const regionsApprovePath = "$_regionAppPath/approve/";
// 设置势力管理员
const regionsAddManagerPath = "$_regionAppPath/add_manager/";
// 移除势力管理员
const regionsRemoveManagerPath = "$_regionAppPath/remove_manager/";
