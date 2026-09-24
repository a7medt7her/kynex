import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kynex/core/services/app_dependencies.dart';
import 'package:kynex/core/unitles/app_color.dart';
import 'package:kynex/features/start/presentation/view/splash_screen.dart';
import 'package:kynex/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  setupServices();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 876),
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: AppColors.black,
            appBarTheme: AppBarTheme(backgroundColor: AppColors.black3),
          ),
          home: SplashScreen(),
        );
      },
    );
  }
}
