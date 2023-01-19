import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_code_scanner/page/Test/coba.dart';
import 'package:qr_code_scanner/page/qr_create_page.dart';
import 'package:qr_code_scanner/page/qr_scan_page.dart';
import 'package:qr_code_scanner/page/qr_scan_pagecopy.dart';
import 'package:qr_code_scanner/widget/button_widget.dart';

import 'fitness_app/fitness_app_home_screen.dart';
import 'fitness_app/training/training_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final String title = 'QR PEMELIHARAAN IT Aset';

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(
          primaryColor: Colors.green,
          // scaffoldBackgroundColor: Colors.black,
        ),
        home: MainPage(title: title),
        initialRoute: '/',
        routes: {
          '/coba': (context) => Coba(),
          '/qr': (context) => QRScanPage(),
          '/tes': (context) => QRScanPageCop(),
        },
      );
}

class MainPage extends StatefulWidget {
  final String title;

  const MainPage({
    @required this.title,
  });

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.blueGrey,
        body: Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 100),
              Image.asset(
                'assets/IT.png',
                height: 150,
                width: 280,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 32),
              ButtonWidget(
                text: 'Create QR Code',
                onClicked: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => QRCreatePage(),
                )),
              ),
              const SizedBox(height: 32),
              ButtonWidget(
                text: 'Scan Data',
                onClicked: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => QRScanPageCop(),
                )),
              ),
              const SizedBox(height: 32),
              ButtonWidget(
                text: 'LIST DATA',
                onClicked: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => Coba(),
                )),
              ),
              const SizedBox(height: 32),
              ButtonWidget(
                text: 'UI TES',
                onClicked: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => FitnessAppHomeScreen(),
                )),
              ),
            ],
          ),
        ),
      );
}
