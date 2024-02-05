import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:snapdrive/db/datamodel.dart';
import 'package:snapdrive/screens/splash.dart';

const saveKey = 'userLoggedIn';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(CarModelAdapter().typeId)) {
    Hive.registerAdapter(CarModelAdapter());
  }
  if (!Hive.isAdapterRegistered(CustomerModelAdapter().typeId)) {
    Hive.registerAdapter(CustomerModelAdapter());
  }
  await Hive.openBox<CarModel>('car_db');
  await Hive.openBox<CustomerModel>('customer_db');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 10, 47, 39)),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: Splash(),
    );
  }
}
