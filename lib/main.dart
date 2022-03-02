import 'package:firebase_core/firebase_core.dart';
import 'package:firenoteapp/detail_page.dart';
import 'package:firenoteapp/hive_service.dart';
import 'package:firenoteapp/service/configuration_service.dart';
import 'package:firenoteapp/sign_in_page.dart';
import 'package:firenoteapp/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import 'home_page.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox(HiveDB.DB_NAME);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: Configurations.apiKey,
        appId: Configurations.appId,
        messagingSenderId: Configurations.messagingSenderId,
        projectId: Configurations.projectId),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SignInPage(),
      routes: {
        SignInPage.id: (context) => SignInPage(),
        SignUpPage.id: (context) => SignUpPage(),
        HomePage.id: (context) => HomePage(),
        DetailPage.id: (context) => DetailPage(),
      },
    );
  }
}
