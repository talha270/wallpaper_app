import 'package:api_tutorials/model/buttomnavigationscreen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import'package:hive_flutter/hive_flutter.dart';
Future<void> main() async{
  await Hive.initFlutter();
  await _initapp();
  runApp(const MyApp());
}

Future _initapp() async{
  await Hive.openBox("favourite1");
  if(await Hive.box("favourite1").get("list")==null){
    await Hive.box("favourite1").put("list", List<dynamic>.empty(growable: true));
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:
      // const Wallpaper(title: "Wallpaper"),
      const Buttomnavigationscreen(),
    );
  }
}
