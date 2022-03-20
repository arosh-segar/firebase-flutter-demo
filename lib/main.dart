import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import './screens/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          appId: '1:733218044611:web:0a0b339ede1e54963a8076',
          apiKey: 'AIzaSyDVOoQlvVA4m-1_I-dRj-D3vxmvXjpcVvw',
          messagingSenderId: '733218044611',
          projectId: 'fir-crud-demo-2846e'));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowMaterialGrid: false,
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        Home.routeName: (context) => const Home(title: 'Home'),
      },
    );
  }
}
