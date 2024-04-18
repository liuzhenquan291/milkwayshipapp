import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../modules/root/app_bindings.dart';
import 'core/apps.dart';
import 'modules/root/splash_service.dart';
import 'modules/root/splash_view.dart';

void main() {
  runApp(MyApp(
    initialRoute: AppRoute.rootPage,
    initialBinding: AppBindings(),
    onGetPages: () => AppRoute.getPages(),
  ));
}

class MyApp extends StatelessWidget {
  final String? initialRoute;
  final Bindings? initialBinding;
  final List<GetPage>? Function()? onGetPages;

  const MyApp({
    Key? key,
    this.initialRoute,
    this.initialBinding,
    this.onGetPages,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: initialBinding,
      initialRoute: initialRoute,
      getPages: onGetPages == null ? [] : onGetPages!(),
      builder: (context, child) {
        // final botToastBuilder = BotToastInit();
        // child = botToastBuilder(context, child);

        return FutureBuilder<void>(
          key: const ValueKey('initFuture'),
          future: Get.find<SplashService>().init(),
          builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
            print("snapshot=${snapshot.connectionState}");
            if (snapshot.connectionState == ConnectionState.done) {
              return child ?? const SizedBox.shrink();
            }
            return SplashView();
          },
        );
      },
    );
  }
}
