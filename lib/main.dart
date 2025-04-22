import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:quiet_recall/core/constants/app_color.dart';
import 'package:quiet_recall/model/card_model.dart';
import 'package:quiet_recall/view/splash_screen.dart';
import 'package:quiet_recall/view_model/game_view_model.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(CardModelAdapter());
  await Hive.openBox('gamestats');
  runApp(
    ChangeNotifierProvider(create: (_) => GameViewModel(), child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: AppColor.primaryColor,
        appBarTheme: AppBarTheme(
          backgroundColor: AppColor.primaryColor,
          iconTheme: IconThemeData(color: AppColor.iconPrimaryColor),
        ),
        textTheme: TextTheme(
          bodyMedium: TextStyle(color: AppColor.textprimaryColor),
          bodyLarge: TextStyle(color: AppColor.textprimaryColor),
          titleMedium: TextStyle(color: AppColor.textprimaryColor),
          titleLarge: TextStyle(color: AppColor.textprimaryColor),
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: SplashScreen(),
    );
  }
}
