import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/network/api_helper.dart';
import 'package:flutter_application_1/core/router/app_router.dart';
import 'package:flutter_application_1/core/router/routes.dart';
import 'package:flutter_application_1/core/network/local_data.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await APIHelper.init();
  await LocalData.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter = AppRouter();
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Grow',
          theme: ThemeData(
            useMaterial3: true,
          ),
          onGenerateRoute: appRouter.onGenerateRoute,
          initialRoute: Routes.splashScreen,
        );
      },
    );
  }
}
