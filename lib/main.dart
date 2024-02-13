import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_flutter/bloc/bloc_observer.dart';
import 'package:task_flutter/screen/HomePage.dart';
import 'package:task_flutter/utils/themeColor.dart';

Future<void> main() async {
  await runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('Init', false);
    Bloc.observer = MyBlocObserver();
    runApp(const MyApp());
  }, (error, stackTrace) {
    debugPrint(error.toString());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0x00641F21),
        textSelectionTheme: TextSelectionThemeData(
            selectionHandleColor: ColorsFave.primaryColor),
      ),
      themeMode: ThemeMode.system,
      home: const HomeScreen(),
    );
  }
}
