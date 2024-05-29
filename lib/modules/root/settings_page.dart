import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/go.dart';
import '../../core/list_item.dart';
import '../../core/list_item_group.dart';
import '../../core/state.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  SettingsPage createState() => _SettingsPageState();
}

class _SettingsPageState extends SPStateKeepAlive<SettingsPage> {
  @override
  bool get wantKeepAlive => true;

  Future theme(ThemeMode? mode) async {
    bool isDark = kIsDark;

    // Get.changeTheme(kIsDark ? ThemeData.light() : ThemeData.dark());
    Get.changeTheme(
        mode == ThemeMode.light ? ThemeData.light() : ThemeData.dark());
    SettingsProvider setting =
        Provider.of<SettingsProvider>(context, listen: false);

    return setting.switchThemeModeTo(isDark ? ThemeMode.light : ThemeMode.dark);
  }

  String? getThemeMode() {
    return kIsDark
        ? kThemeModeInfo[ThemeMode.dark].toString()
        : kThemeModeInfo[ThemeMode.light].toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('设置'),
      ),
      body: Container(
          color: Colors.indigo,
          child: Column(
            children: [
              SPListItemGroup(
                items: [
                  // SPListItem(
                  //   left: '消息设置',
                  //   onTap: () {
                  //     // HGRoutes.feedback(context);
                  //     Go.push(Routes.app.messageSettings);
                  //   },
                  // ),
                  SPListItem(
                    left: '帮助和建议', //'问题反馈',
                    onTap: () {
                      // HGRoutes.feedback(context);
                      // Go.push(Routes.app.helpAndSuggest);
                    },
                  ),
                  // SPListItem(
                  //   left: 'Proxy Setting',
                  //   onTap: () {
                  //     Go.push(Routes.app.proxySetting);
                  //   },
                  // ),
                  SPListItem(
                    left: '关于揽月',
                    right:
                        // '$appName $platform $versionInfo (build$_buildNumber) $env',
                        'v0.2.0(build030)',
                    onTap: () {
                      // Go.push(Routes.app.aboutInfo);
                    },
                  ),
                  // SPListItem(
                  //   left: '测试一下',
                  //   onTap: () {
                  //     Phoenix.rebirth(context);
                  //   },
                  // ),
                  SPListItem(
                    left: '检查更新',
                    // showFlag: appVersionProvider.latestVersion != null &&
                    //     appVersionProvider.currentVersion != null &&
                    //     appVersionProvider.latestVersion! >
                    //         appVersionProvider.currentVersion!,
                    onTap: () {
                      // appVersionProvider.manualCheckUpdate(context);
                    },
                  ),
                  // if (kDebugMode)
                  // SPListItem(
                  //   left: '更换主题',
                  //   right: getThemeMode(),
                  //   onTap: () {
                  //     //kIsDark?ThemeMode.light:ThemeMode.dark
                  //     changeTheme(context, (themeMode) {
                  //       showLoading(theme(themeMode));
                  //     });
                  //   },
                  // ),
                  // if (kDebugMode)
                  //   SPListItem(
                  //     left: 'Proxy Setting',
                  //     onTap: () {
                  //       //kIsDark?ThemeMode.light:ThemeMode.dark
                  //       setProxy();
                  //     },
                  //   ),
                ],
              ),
            ],
          )),
    );
  }
}
