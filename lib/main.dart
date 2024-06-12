import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'qr_scanner_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShadApp.material(
      materialThemeBuilder: (context, theme) {
        return ThemeData.dark().copyWith(
          appBarTheme: const AppBarTheme(toolbarHeight: 52),
        );
      },
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Code Scanner App'),
      ),
      body: Center(
        child: ShadButton(
          text: const Text('Open QR Scanner'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => QRScannerScreen()),
            );
          },
        ),
      ),
    );
  }
}
