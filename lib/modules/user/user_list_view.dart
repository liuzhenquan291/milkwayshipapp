// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:milkwayshipapp/modules/user/user_list_controller.dart';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:milkwayshipapp/modules/user/user_models.dart';

// class UserListPage extends StatefulWidget {
//   @override
//   _UserListPageState createState() => _UserListPageState();
// }

// class _UserListPageState extends State<UserListPage> {
//   final UserListController userController = Get.find();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('User List'),
//       ),
//       body: Obx(() {
//         if (userController.isLoading.value && userController.userList.isEmpty) {
//           return Center(child: CircularProgressIndicator());
//         } else {
//           return ListView.builder(
//             controller: userController.scrollController,
//             itemCount: userController.userList.length,
//             itemBuilder: (context, index) {
//               var user = userController.userList[index];
//               return ListTile(
//                 title: Text('用户名: ${user.username}'),
//                 subtitle: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text('用户昵称: ${user.displayName}'),
//                     Text('用户微信昵称: ${user.wechatName}'),
//                     Text('用户状态: ${user.status}'),
//                   ],
//                 ),
//                 // Add other fields as needed
//               );
//             },
//           );
//         }
//       }),
//     );
//   }
// }
