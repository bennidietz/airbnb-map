import 'package:airbnb_map/presentation/widgets/map_view.dart';
import 'package:airbnb_map/res/colors.dart';
import 'package:flutter/material.dart';

import 'SizeConfig.dart';
import 'injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initInjections();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            SizeConfig().init(constraints, orientation);
            return const MyMaterialApp();
          },
        );
      },
    );
  }
}

class MyMaterialApp extends StatelessWidget {
  const MyMaterialApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Apartment über 2 Etagen nahe BVB-Stadion und Messe',
      theme: ThemeData(
        primarySwatch: MyColors.primaryColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MapView(),
    );
  }
}
